#!/usr/bin/env python3

from __future__ import annotations

import json
import re
import sys
from pathlib import Path


SEMVER = re.compile(r"^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$")


def load(path: Path) -> dict[str, object]:
    with path.open(encoding="utf-8") as handle:
        return json.load(handle)


def validate(root: Path) -> list[str]:
    errors: list[str] = []
    codex = load(root / ".codex-plugin" / "plugin.json")
    claude = load(root / ".claude-plugin" / "plugin.json")
    marketplace = load(root / ".claude-plugin" / "marketplace.json")
    entries = marketplace.get("plugins")
    if not isinstance(entries, list) or len(entries) != 1 or not isinstance(entries[0], dict):
        return ["Claude marketplace must contain exactly one plugin entry"]
    market_plugin = entries[0]

    versions = {str(codex.get("version", "")), str(claude.get("version", "")), str(market_plugin.get("version", ""))}
    if len(versions) != 1:
        errors.append(f"manifest versions differ: {sorted(versions)}")
        return errors
    version = versions.pop()
    if not SEMVER.fullmatch(version):
        errors.append(f"invalid semantic version: {version}")

    for label, manifest in (("Codex", codex), ("Claude", claude), ("Claude marketplace", market_plugin)):
        if manifest.get("name") != "pstack":
            errors.append(f"{label} manifest name is not pstack")
        if manifest.get("skills") not in {"./skills", "./skills/"}:
            errors.append(f"{label} manifest has invalid skills path")

    interface = codex.get("interface")
    if not isinstance(interface, dict):
        errors.append("Codex manifest is missing interface metadata")
    else:
        capabilities = interface.get("capabilities")
        if capabilities != ["Skills"]:
            errors.append("Codex capabilities must describe the packaged Skills component only")
        if "agent" in str(interface.get("longDescription", "")).lower():
            errors.append("Codex longDescription advertises agents that are not packaged")

    changelog = (root / "CHANGELOG.md").read_text(encoding="utf-8")
    if f"## [{version}]" not in changelog:
        errors.append(f"CHANGELOG.md has no entry for {version}")

    pin = (root / "UPSTREAM_COMMIT").read_text(encoding="utf-8").strip()
    if not re.fullmatch(r"[0-9a-f]{40}", pin):
        errors.append("UPSTREAM_COMMIT is not a full lowercase commit SHA")

    return errors


if __name__ == "__main__":
    target = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parent.parent
    failures = validate(target.resolve())
    if failures:
        for failure in failures:
            print(f"FAIL: {failure}")
        raise SystemExit(1)
    print("ok: manifests, version, changelog, and upstream pin")
