#!/bin/sh

set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
VALIDATE_TEMP=$(mktemp -d "${TMPDIR:-/tmp}/pstack-validate.XXXXXX")
PY_CACHE="$VALIDATE_TEMP/pycache"
trap 'rm -rf "$VALIDATE_TEMP"' EXIT HUP INT TERM
cd "$ROOT"

python3 scripts/validate-content.py .


for name in $(awk -F '\t' 'NR > 1 && $3 == "patch" { print $2 }' upstream-policy.tsv); do
    git apply --reverse --check "patches/$name.patch" ||
        { echo "FAIL: skills/$name does not contain patches/$name.patch" >&2; exit 1; }
done
echo 'ok: patch skills contain their local patches'

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
grep -A8 '^permission:' .opencode/agents/comment-sicko.md | grep -q '^  edit: allow$'
grep -A8 '^permission:' .opencode/agents/comment-sicko.md | grep -q '^  bash: allow$'
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
    XDG_DATA_HOME="$VALIDATE_TEMP/data" XDG_CACHE_HOME="$VALIDATE_TEMP/cache" opencode debug agents > "$VALIDATE_TEMP/agents.json"
    grep -q '"id": "poteto-agent"' "$VALIDATE_TEMP/agents.json"
    grep -q '"id": "comment-sicko"' "$VALIDATE_TEMP/agents.json"
    echo 'ok: OpenCode agent discovery'
else
    echo 'ok: OpenCode CLI absent, discovery skipped'
fi

echo 'VALIDATE: all green'
