#!/usr/bin/env python3

from __future__ import annotations

import os
import re
import shutil
import sys
import tempfile
from pathlib import Path
from typing import NoReturn


SKIPPED_SKILLS = frozenset({"automate-me", "reflect", "setup-pstack"})
SKIPPED_PLAYBOOKS = frozenset(
    {"autopilot-full.md", "autopilot-stack.md", "orchestrate.md", "shipping.md"}
)
FRONTMATTER_KEYS_TO_DROP = frozenset(
    {"color", "disable-model-invocation", "icon", "mode", "reminder"}
)
TEXT_SUFFIXES = frozenset({".md", ".tsv"})
SUBSTITUTIONS = (
    (re.compile(r"/create-skill(?=[^a-z0-9-]|$)"), "skill-creator"),
    (re.compile(r"/deslop(?=[^a-z0-9-]|$)"), "unslop followed by manual review"),
    (
        re.compile(r"(?<![A-Za-z0-9-])control-cli(?=[^a-z0-9-]|$)"),
        "the host's CLI testing tool",
    ),
    (
        re.compile(r"(?<![A-Za-z0-9-])control-ui(?=[^a-z0-9-]|$)"),
        "the host's UI testing tool",
    ),
    (re.compile(r"\.cursor-plugin"), "plugin manifest"),
    (re.compile(r"`?subagent_type`?"), "subagent role"),
    (re.compile(r"`?/loop`?"), "repeat until the exit condition passes"),
    (re.compile(r"`?AskQuestion`?"), "ask the user"),
    (
        re.compile(r"~/.cursor/rules/pstack-models\.mdc"),
        "the host's optional model configuration",
    ),
    (re.compile(r"claude-fable-5-thinking-max"), "a judgment-focused available model"),
    (re.compile(r"gpt-5\.6-sol-max"), "a strong implementation model"),
    (re.compile(r"grok-4\.6-fast-xhigh"), "a fast available model"),
    (re.compile(r"claude-opus-5-thinking-xhigh"), "another judgment-focused available model"),
    (re.compile(r"`Task` calls?"), "subagent calls"),
    (re.compile(r"Task calls?"), "subagent calls"),
    (re.compile(r"Task tool"), "host's subagent tool"),
    (re.compile(r"Task subagent"), "subagent"),
)


def fail(message: str) -> NoReturn:
    raise SystemExit(f"error: {message}")


def rewrite_frontmatter(text: str, skill_name: str | None, agent: bool) -> str:
    lines = text.splitlines(keepends=True)
    if not lines or lines[0].strip() != "---":
        return text

    try:
        end = next(index for index, line in enumerate(lines[1:], 1) if line.strip() == "---")
    except StopIteration:
        fail("unterminated YAML frontmatter")

    rewritten = [lines[0]]
    saw_name = False
    for line in lines[1:end]:
        match = re.match(r"^([A-Za-z0-9_-]+):", line)
        key = match.group(1) if match else None
        if key in FRONTMATTER_KEYS_TO_DROP:
            continue
        if key == "is_background" and agent:
            rewritten.append(line.replace("is_background:", "background:", 1))
            continue
        if key == "name" and skill_name:
            newline = "\n" if line.endswith("\n") else ""
            rewritten.append(f"name: {skill_name}{newline}")
            saw_name = True
            continue
        rewritten.append(line)

    if skill_name and not saw_name:
        fail(f"missing name in skill {skill_name}")

    return "".join((*rewritten, lines[end], *lines[end + 1 :]))


def rewrite_text(path: Path, root: Path) -> str:
    text = path.read_text(encoding="utf-8")
    relative = path.relative_to(root)
    skill_name = None
    if len(relative.parts) == 3 and relative.parts[0] == "skills" and relative.name == "SKILL.md":
        skill_name = relative.parts[1]

    text = rewrite_frontmatter(text, skill_name, relative.parts[0] == "agents")
    for pattern, replacement in SUBSTITUTIONS:
        text = pattern.sub(replacement, text)

    text = text.replace(
        "description: Restate the last message in plain human language, with no jargon.",
        "description: Use when the user asks to restate or explain the last message in plain, jargon-free language.",
    )
    text = text.replace(
        'description: "Spawn Comment Sicko, fix accepted findings, and offer encodings for claimed constraints."',
        "description: Use before review when the user asks to strip, remove, or clean up comments in code.",
    )
    return text


def text_paths(root: Path) -> list[Path]:
    roots = [root / "skills", root / "agents", root / "docs" / "guide"]
    return sorted(
        path
        for base in roots
        if base.exists()
        for path in base.rglob("*")
        if path.is_file() and path.suffix in TEXT_SUFFIXES
    )


def write_atomic(path: Path, text: str) -> None:
    descriptor, temporary = tempfile.mkstemp(prefix=f".{path.name}.", dir=path.parent)
    try:
        with os.fdopen(descriptor, "w", encoding="utf-8", newline="") as handle:
            handle.write(text)
        os.replace(temporary, path)
    except BaseException:
        try:
            os.unlink(temporary)
        except FileNotFoundError:
            pass
        raise


def adapt(root: Path) -> None:
    root = root.resolve()
    skills = root / "skills"
    if not skills.is_dir():
        fail(f"{root} does not contain skills/")

    changes: dict[Path, str] = {}
    for path in text_paths(root):
        rewritten = rewrite_text(path, root)
        if rewritten != path.read_text(encoding="utf-8"):
            changes[path] = rewritten

    for path, text in changes.items():
        write_atomic(path, text)

    for name in SKIPPED_SKILLS:
        target = skills / name
        if target.exists():
            shutil.rmtree(target)

    playbooks = skills / "poteto-mode" / "playbooks"
    for name in SKIPPED_PLAYBOOKS:
        target = playbooks / name
        if target.exists():
            target.unlink()

    print(
        f"adapted {len(changes)} files; skipped "
        f"{len(SKIPPED_SKILLS)} skills and {len(SKIPPED_PLAYBOOKS)} playbooks"
    )


if __name__ == "__main__":
    adapt(Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parent.parent)
