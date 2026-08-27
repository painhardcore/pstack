#!/bin/sh

set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
FIXTURE=$(mktemp -d "${TMPDIR:-/tmp}/pstack-adapter-test.XXXXXX")
BEFORE="${FIXTURE}.before"
trap 'rm -rf "$FIXTURE" "$BEFORE"' EXIT HUP INT TERM

mkdir -p \
    "$FIXTURE/skills/example/references" \
    "$FIXTURE/skills/poteto-mode/playbooks" \
    "$FIXTURE/agents" \
    "$FIXTURE/docs/guide"

for name in automate-me reflect setup-pstack; do
    mkdir -p "$FIXTURE/skills/$name"
done

printf '%s\n' \
    '---' \
    'name: Example Skill' \
    'description: Example skill.' \
    'disable-model-invocation: true' \
    'mode: agent' \
    'icon: bolt' \
    'color: blue' \
    'reminder: test' \
    '---' \
    '' \
    'Use /create-skill, then /deslop.' \
    'Run control-cli from the .cursor-plugin.' \
    'Run control-ui, then AskQuestion.' \
    'Read ~/.cursor/rules/pstack-models.mdc.' \
    'Models: claude-fable-5-thinking-max, gpt-5.6-sol-max, grok-4.6-fast-xhigh, claude-opus-5-thinking-xhigh.' \
    'Set `subagent_type` for each Task call.' \
    > "$FIXTURE/skills/example/SKILL.md"

printf '%s\n' 'reference uses /create-skill' > "$FIXTURE/skills/example/references/example.md"
for name in automate-me reflect setup-pstack; do
    printf '%s\n' '---' "name: $name" 'description: Cursor-only.' '---' > "$FIXTURE/skills/$name/SKILL.md"
done
for name in autopilot-full autopilot-stack orchestrate shipping; do
    printf '%s\n' "# $name" > "$FIXTURE/skills/poteto-mode/playbooks/$name.md"
done
printf '%s\n' '# Bug fix' 'Use /loop.' > "$FIXTURE/skills/poteto-mode/playbooks/bug-fix.md"
printf '%s\n' '---' 'name: helper' 'description: Helper.' 'mode: agent' 'is_background: true' '---' > "$FIXTURE/agents/helper.md"
printf '%s\n' 'Use /create-skill.' > "$FIXTURE/docs/guide/example.md"

python3 "$ROOT/scripts/adapt_skills.py" "$FIXTURE"

grep -q '^name: example$' "$FIXTURE/skills/example/SKILL.md"
! grep -qE '^(disable-model-invocation|mode|icon|color|reminder):' "$FIXTURE/skills/example/SKILL.md"
grep -q 'skill-creator' "$FIXTURE/skills/example/SKILL.md"
grep -q 'unslop followed by manual review' "$FIXTURE/skills/example/SKILL.md"
grep -q "host's CLI testing tool" "$FIXTURE/skills/example/SKILL.md"
grep -q "host's UI testing tool" "$FIXTURE/skills/example/SKILL.md"
grep -q 'plugin manifest' "$FIXTURE/skills/example/SKILL.md"
grep -q 'subagent role' "$FIXTURE/skills/example/SKILL.md"
grep -q 'ask the user' "$FIXTURE/skills/example/SKILL.md"
grep -q "host's optional model configuration" "$FIXTURE/skills/example/SKILL.md"
grep -q 'a judgment-focused available model' "$FIXTURE/skills/example/SKILL.md"
grep -q 'a strong implementation model' "$FIXTURE/skills/example/SKILL.md"
grep -q 'a fast available model' "$FIXTURE/skills/example/SKILL.md"
grep -q 'another judgment-focused available model' "$FIXTURE/skills/example/SKILL.md"
! grep -q 'Task call' "$FIXTURE/skills/example/SKILL.md"
grep -q 'repeat until the exit condition passes' "$FIXTURE/skills/poteto-mode/playbooks/bug-fix.md"
grep -q '^background: true$' "$FIXTURE/agents/helper.md"
! grep -q '^mode:' "$FIXTURE/agents/helper.md"
for name in automate-me reflect setup-pstack; do
    [ ! -e "$FIXTURE/skills/$name" ]
done
for name in autopilot-full autopilot-stack orchestrate shipping; do
    [ ! -e "$FIXTURE/skills/poteto-mode/playbooks/$name.md" ]
done

cp -R "$FIXTURE" "$BEFORE"
python3 "$ROOT/scripts/adapt_skills.py" "$FIXTURE"
diff -rq "$BEFORE" "$FIXTURE" >/dev/null

INVALID=$(mktemp -d "${TMPDIR:-/tmp}/pstack-adapter-invalid.XXXXXX")
if python3 "$ROOT/scripts/adapt_skills.py" "$INVALID" >/dev/null 2>&1; then
    rm -rf "$INVALID"
    echo 'adapter accepted a root without skills/' >&2
    exit 1
fi
[ -z "$(find "$INVALID" -mindepth 1 -print -quit)" ]
rm -rf "$INVALID"

echo 'ok: adapter behavior and idempotency'
