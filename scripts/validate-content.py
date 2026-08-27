#!/usr/bin/env python3

from __future__ import annotations

import ast
import re
import sys
from pathlib import Path

from adapt_skills import SKIPPED_PLAYBOOKS, SKIPPED_SKILLS


NAME = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
LINK = re.compile(r"\[[^]]*]\(([^)]+)\)")
HELPER = re.compile(r"(?<![A-Za-z0-9_.-])(scripts/[A-Za-z0-9_./-]+)")
BANNED = {
    "Cursor-only instruction": re.compile(r"Cursor|\.cursor"),
    "Cursor question tool": re.compile(r"AskQuestion"),
    "Cursor loop command": re.compile(r"(?<![A-Za-z0-9-])/loop(?![A-Za-z0-9-])"),
    "Cursor subagent field": re.compile(r"subagent_type|run_in_background|environment: [\"']cloud[\"']"),
    "Cursor model slug": re.compile(
        r"claude-fable-5-thinking-max|gpt-5\.6-sol-max|grok-4\.6-fast-xhigh|claude-opus-5-thinking-xhigh"
    ),
    "Graphite workflow": re.compile(r"Graphite|\bgt (?:submit|merge|restack)\b"),
    "missing-helper banner": re.compile(r"helper pending", re.IGNORECASE),
    "host-specific Task syntax": re.compile(r"\bTask (?:tool|subagent|call)s?\b"),
}
CLAUDE_AGENT_FIELDS = frozenset(
    {
        "name",
        "description",
        "model",
        "effort",
        "maxTurns",
        "tools",
        "disallowedTools",
        "skills",
        "memory",
        "background",
        "isolation",
    }
)


def scalar(value: str) -> str:
    value = value.strip()
    if len(value) >= 2 and value[0] == value[-1] and value[0] in "\"'":
        try:
            return str(ast.literal_eval(value))
        except (SyntaxError, ValueError):
            return value[1:-1]
    return value


def frontmatter(path: Path) -> dict[str, str]:
    lines = path.read_text(encoding="utf-8").splitlines()
    if not lines or lines[0] != "---":
        raise ValueError("missing opening frontmatter delimiter")
    try:
        end = lines.index("---", 1)
    except ValueError as error:
        raise ValueError("missing closing frontmatter delimiter") from error

    result: dict[str, str] = {}
    index = 1
    while index < end:
        line = lines[index]
        if not line or line[0].isspace() or ":" not in line:
            index += 1
            continue
        key, value = line.split(":", 1)
        value = value.strip()
        if value in {">", ">-", "|", "|-"}:
            index += 1
            parts: list[str] = []
            while index < end and (not lines[index] or lines[index][0].isspace()):
                parts.append(lines[index].strip())
                index += 1
            result[key] = " ".join(part for part in parts if part)
            continue
        result[key] = scalar(value)
        index += 1
    return result


def markdown_files(root: Path) -> list[Path]:
    paths: list[Path] = []
    for relative in ("README.md", "AGENTS.md", "UPSTREAM_SYNC.md"):
        path = root / relative
        if path.exists():
            paths.append(path)
    for relative in ("skills", "agents", "docs"):
        base = root / relative
        if base.exists():
            paths.extend(base.rglob("*.md"))
    return sorted(set(paths))


def policy_entries(path: Path) -> dict[tuple[str, str], str]:
    entries: dict[tuple[str, str], str] = {}
    lines = path.read_text(encoding="utf-8").splitlines()
    if not lines or lines[0] != "kind\tname\taction":
        raise ValueError("bad upstream-policy.tsv header")
    for number, line in enumerate(lines[1:], 2):
        parts = line.split("\t")
        if len(parts) != 3:
            raise ValueError(f"bad upstream-policy.tsv row {number}")
        kind, name, action = parts
        if kind not in {"skill", "playbook", "agent"} or action not in {"sync", "adapt", "skip"}:
            raise ValueError(f"bad upstream-policy.tsv row {number}")
        key = (kind, name)
        if key in entries:
            raise ValueError(f"duplicate upstream policy for {kind} {name}")
        entries[key] = action
    return entries


def validate(root: Path) -> list[str]:
    root = root.resolve()
    errors: list[str] = []
    skills = root / "skills"
    if not skills.is_dir():
        return [f"{root} does not contain skills/"]

    skill_names: set[str] = set()
    for directory in sorted(path for path in skills.iterdir() if path.is_dir()):
        path = directory / "SKILL.md"
        if not path.is_file():
            errors.append(f"missing SKILL.md: {directory.relative_to(root)}")
            continue
        skill_names.add(directory.name)
        try:
            metadata = frontmatter(path)
        except ValueError as error:
            errors.append(f"{path.relative_to(root)}: {error}")
            continue
        name = metadata.get("name", "")
        description = metadata.get("description", "")
        if name != directory.name:
            errors.append(f"{path.relative_to(root)}: name {name!r} does not match directory")
        if not NAME.fullmatch(name) or len(name) > 64:
            errors.append(f"{path.relative_to(root)}: invalid skill name {name!r}")
        if not 1 <= len(description) <= 1024:
            errors.append(f"{path.relative_to(root)}: description length is {len(description)}")

    for name in SKIPPED_SKILLS:
        if name in skill_names:
            errors.append(f"Cursor-only skill shipped: {name}")

    playbook_dir = skills / "poteto-mode" / "playbooks"
    playbook_names = {path.stem for path in playbook_dir.glob("*.md")}
    for filename in SKIPPED_PLAYBOOKS:
        if Path(filename).stem in playbook_names:
            errors.append(f"Cursor-only playbook shipped: {filename}")

    portable_files = list(skills.rglob("*.md")) + list((root / "agents").glob("*.md"))
    for path in portable_files:
        text = path.read_text(encoding="utf-8")
        for label, pattern in BANNED.items():
            if pattern.search(text):
                errors.append(f"{path.relative_to(root)}: {label}")

        for reference in HELPER.findall(text):
            local = path.parent / reference
            repository = root / reference
            if not local.exists() and not repository.exists():
                errors.append(f"{path.relative_to(root)}: missing helper {reference}")

    for path in markdown_files(root):
        for target in LINK.findall(path.read_text(encoding="utf-8")):
            target = target.strip().strip("<>")
            if not target or target.startswith(("http://", "https://", "mailto:", "#")):
                continue
            relative = target.split("#", 1)[0]
            if relative == "url":
                continue
            if relative and not (path.parent / relative).exists():
                errors.append(f"{path.relative_to(root)}: broken link {target}")

    agent_paths = sorted((root / "agents").glob("*.md"))
    agent_names = {path.stem for path in agent_paths}
    for path in agent_paths:
        try:
            metadata = frontmatter(path)
        except ValueError as error:
            errors.append(f"{path.relative_to(root)}: {error}")
            continue
        if metadata.get("name") != path.stem:
            errors.append(f"{path.relative_to(root)}: agent name does not match filename")
        unknown = set(metadata) - CLAUDE_AGENT_FIELDS
        if unknown:
            errors.append(f"{path.relative_to(root)}: unsupported Claude agent fields {sorted(unknown)}")

    policy_path = root / "upstream-policy.tsv"
    if policy_path.exists():
        try:
            policy = policy_entries(policy_path)
        except ValueError as error:
            errors.append(str(error))
        else:
            expected_skills = skill_names | set(SKIPPED_SKILLS)
            classified_skills = {name for (kind, name) in policy if kind == "skill"}
            if expected_skills != classified_skills:
                errors.append("upstream skill policy does not match shipped and skipped skills")
            expected_playbooks = playbook_names | {Path(name).stem for name in SKIPPED_PLAYBOOKS}
            classified_playbooks = {name for (kind, name) in policy if kind == "playbook"}
            if expected_playbooks != classified_playbooks:
                errors.append("upstream playbook policy does not match shipped and skipped playbooks")
            classified_agents = {name for (kind, name) in policy if kind == "agent"}
            if agent_names != classified_agents:
                errors.append("upstream agent policy does not match shipped agents")
            for kind, names in (
                ("skill", SKIPPED_SKILLS),
                ("playbook", {Path(name).stem for name in SKIPPED_PLAYBOOKS}),
            ):
                for name in names:
                    if policy.get((kind, name)) != "skip":
                        errors.append(f"upstream {kind} policy must skip {name}")
            for kind, names in (("skill", skill_names), ("playbook", playbook_names), ("agent", agent_names)):
                for name in names:
                    if policy.get((kind, name)) == "skip":
                        errors.append(f"shipped {kind} is marked skip: {name}")

    return errors


if __name__ == "__main__":
    target = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parent.parent
    failures = validate(target)
    if failures:
        for failure in failures:
            print(f"FAIL: {failure}")
        raise SystemExit(1)
    print("ok: portable skills, agents, links, helpers, and upstream policy")
