#!/bin/sh

set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
VALIDATE_TEMP=$(mktemp -d "${TMPDIR:-/tmp}/pstack-validate.XXXXXX")
PY_CACHE="$VALIDATE_TEMP/pycache"
trap 'rm -rf "$VALIDATE_TEMP"' EXIT HUP INT TERM
cd "$ROOT"

python3 scripts/validate-content.py .

diff -rq skills .opencode/skills >/dev/null
echo 'ok: skills/ matches .opencode/skills/'

python3 scripts/validate-packaging.py .

for manifest in .codex-plugin/plugin.json .claude-plugin/plugin.json .claude-plugin/marketplace.json; do
    python3 -m json.tool "$manifest" >/dev/null
done
echo 'ok: manifest JSON'

for script in scripts/*.sh; do
    sh -n "$script"
    [ -x "$script" ] || { echo "FAIL: script is not executable: $script" >&2; exit 1; }
done
PYTHONPYCACHEPREFIX="$PY_CACHE" python3 -m py_compile scripts/*.py
echo 'ok: script syntax and executable bits'

for agent in .opencode/agents/*.md; do
    name=$(basename "$agent" .md)
    grep -q "^name: $name$" "$agent"
    grep -q '^mode: subagent$' "$agent"
done
grep -A8 '^permission:' .opencode/agents/comment-sicko.md | grep -q '^  edit: deny$'
grep -A8 '^permission:' .opencode/agents/comment-sicko.md | grep -q '^  bash: deny$'
grep -A8 '^permission:' .opencode/agents/comment-sicko.md | grep -q '^  task: deny$'
echo 'ok: OpenCode agent adapters'

sh scripts/test-adapt-skills.sh
sh scripts/test-sync-upstream.sh

if command -v claude >/dev/null 2>&1; then
    claude plugin validate . >/dev/null
    echo 'ok: Claude plugin validation'
else
    echo 'ok: Claude CLI absent, validation skipped'
fi

if command -v opencode >/dev/null 2>&1; then
    XDG_DATA_HOME="$VALIDATE_TEMP/data" XDG_CACHE_HOME="$VALIDATE_TEMP/cache" opencode debug agent poteto-agent >/dev/null
    XDG_DATA_HOME="$VALIDATE_TEMP/data" XDG_CACHE_HOME="$VALIDATE_TEMP/cache" opencode debug agent comment-sicko >/dev/null
    echo 'ok: OpenCode agent discovery'
else
    echo 'ok: OpenCode CLI absent, discovery skipped'
fi

echo 'VALIDATE: all green'
