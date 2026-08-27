#!/bin/sh

set -eu

UPSTREAM_REPO=${PSTACK_UPSTREAM_REPO:-https://github.com/cursor/plugins.git}
ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
PIN_FILE="$ROOT/UPSTREAM_COMMIT"
POLICY="$ROOT/upstream-policy.tsv"

[ -f "$PIN_FILE" ] || { echo "error: missing UPSTREAM_COMMIT" >&2; exit 1; }
[ -f "$POLICY" ] || { echo "error: missing upstream-policy.tsv" >&2; exit 1; }

UPSTREAM_COMMIT=$(tr -d '[:space:]' < "$PIN_FILE")
case "$UPSTREAM_COMMIT" in
    *[!0-9a-f]* | "") echo "error: UPSTREAM_COMMIT must be a lowercase commit SHA" >&2; exit 1 ;;
esac
[ "${#UPSTREAM_COMMIT}" -eq 40 ] || { echo "error: UPSTREAM_COMMIT must contain 40 characters" >&2; exit 1; }

TEMP_ROOT=$(mktemp -d "${TMPDIR:-/tmp}/pstack-sync.XXXXXX")
trap 'rm -rf "$TEMP_ROOT"' EXIT HUP INT TERM
CHECKOUT="$TEMP_ROOT/plugins"
STAGE="$TEMP_ROOT/stage"

git init --quiet "$CHECKOUT"
git -C "$CHECKOUT" remote add origin "$UPSTREAM_REPO"
git -C "$CHECKOUT" fetch --quiet --depth 1 origin "$UPSTREAM_COMMIT"
FETCHED=$(git -C "$CHECKOUT" rev-parse FETCH_HEAD)
[ "$FETCHED" = "$UPSTREAM_COMMIT" ] || { echo "error: fetched $FETCHED instead of $UPSTREAM_COMMIT" >&2; exit 1; }
git -C "$CHECKOUT" checkout --quiet --detach FETCH_HEAD

SOURCE="$CHECKOUT/pstack"
[ -d "$SOURCE/skills" ] || { echo "error: upstream commit does not contain pstack/skills" >&2; exit 1; }

policy_action() {
    awk -F '\t' -v kind="$1" -v name="$2" '
        NR > 1 && $1 == kind && $2 == name { print $3 }
    ' "$POLICY"
}

require_classification() {
    action=$(policy_action "$1" "$2")
    [ -n "$action" ] || { echo "error: unclassified upstream $1: $2" >&2; exit 1; }
}

for path in "$SOURCE/skills"/*; do
    [ -d "$path" ] || continue
    require_classification skill "$(basename "$path")"
done
for path in "$SOURCE/skills/poteto-mode/playbooks"/*.md; do
    [ -f "$path" ] || continue
    require_classification playbook "$(basename "$path" .md)"
done
for path in "$SOURCE/agents"/*.md; do
    [ -f "$path" ] || continue
    require_classification agent "$(basename "$path" .md)"
done

TAB=$(printf '\t')
while IFS="$TAB" read -r kind name action; do
    [ "$kind" = "kind" ] && continue
    case "$kind" in
        skill) target="$SOURCE/skills/$name/SKILL.md" ;;
        playbook) target="$SOURCE/skills/poteto-mode/playbooks/$name.md" ;;
        agent) target="$SOURCE/agents/$name.md" ;;
        *) echo "error: invalid policy kind $kind" >&2; exit 1 ;;
    esac
    [ -e "$target" ] || { echo "error: policy names missing upstream $kind: $name" >&2; exit 1; }
done < "$POLICY"

mkdir -p "$STAGE"
cp -R "$ROOT/skills" "$STAGE/skills"
cp -R "$ROOT/agents" "$STAGE/agents"
cp -R "$ROOT/docs" "$STAGE/docs"
cp "$POLICY" "$STAGE/upstream-policy.tsv"

awk -F '\t' 'NR > 1 && $1 == "skill" && $3 == "sync" { print $2 }' "$POLICY" |
while IFS= read -r name; do
    rsync -a --delete "$SOURCE/skills/$name/" "$STAGE/skills/$name/"
done

python3 "$ROOT/scripts/adapt_skills.py" "$STAGE"
python3 "$ROOT/scripts/validate-content.py" "$STAGE"

rsync -a --delete "$STAGE/skills/" "$ROOT/skills/"
rsync -a --delete "$STAGE/agents/" "$ROOT/agents/"
rsync -a --delete "$STAGE/docs/" "$ROOT/docs/"
rsync -a --delete "$ROOT/skills/" "$ROOT/.opencode/skills/"
cp "$SOURCE/LICENSE" "$ROOT/LICENSE"

if [ "${PSTACK_SKIP_FULL_CHECK:-0}" != "1" ]; then
    make -C "$ROOT" check
fi

echo "synced portable paths from cursor/plugins@$UPSTREAM_COMMIT"
echo "review adapt entries in upstream-policy.tsv before changing UPSTREAM_COMMIT"
