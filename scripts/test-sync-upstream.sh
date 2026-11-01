#!/bin/sh

set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
FIXTURE=$(mktemp -d "${TMPDIR:-/tmp}/pstack-sync-test.XXXXXX")
trap 'rm -rf "$FIXTURE"' EXIT HUP INT TERM

UPSTREAM="$FIXTURE/upstream"
WORK="$FIXTURE/work"
mkdir -p "$UPSTREAM/pstack" "$WORK"
rsync -a --exclude='.git' "$ROOT/" "$UPSTREAM/pstack/"
rsync -a --exclude='.git' "$ROOT/" "$WORK/"

for name in automate-me make-bot-ui poteto-help reflect setup-pstack; do
    mkdir -p "$UPSTREAM/pstack/skills/$name"
    printf '%s\n' '---' "name: $name" 'description: Upstream-only skill.' '---' > "$UPSTREAM/pstack/skills/$name/SKILL.md"
done
for name in autopilot-full autopilot-stack orchestrate shipping; do
    printf '%s\n' "# $name" > "$UPSTREAM/pstack/skills/poteto-mode/playbooks/$name.md"
done

git -C "$UPSTREAM/pstack" apply --reverse "$ROOT/patches/statechart.patch"
printf '%s\n' '---' 'name: Bro Upstream' 'description: Synced fixture skill.' '---' '' 'UPSTREAM_SYNC_MARKER' > "$UPSTREAM/pstack/skills/bro/SKILL.md"
printf '%s\n' '---' 'name: How Upstream' 'description: Adapted fixture skill.' '---' '' 'ADAPT_ENTRY_MUST_NOT_OVERWRITE' > "$UPSTREAM/pstack/skills/how/SKILL.md"

git -C "$UPSTREAM" init --quiet
git -C "$UPSTREAM" config user.name pstack-test
git -C "$UPSTREAM" config user.email pstack-test@example.invalid
git -C "$UPSTREAM" add pstack
git -C "$UPSTREAM" commit --quiet -m fixture
PIN=$(git -C "$UPSTREAM" rev-parse HEAD)
printf '%s\n' "$PIN" > "$WORK/UPSTREAM_COMMIT"

PSTACK_UPSTREAM_REPO="$UPSTREAM" PSTACK_SKIP_FULL_CHECK=1 sh "$WORK/scripts/sync-upstream.sh" >/dev/null

grep -q 'UPSTREAM_SYNC_MARKER' "$WORK/skills/bro/SKILL.md"
grep -q '^name: bro$' "$WORK/skills/bro/SKILL.md"
! grep -q 'ADAPT_ENTRY_MUST_NOT_OVERWRITE' "$WORK/skills/how/SKILL.md"
[ ! -e "$WORK/skills/setup-pstack" ]
[ ! -e "$WORK/skills/poteto-mode/playbooks/shipping.md" ]
diff -rq "$WORK/skills" "$WORK/.opencode/skills" >/dev/null
! diff -rq "$UPSTREAM/pstack/skills/statechart" "$ROOT/skills/statechart" >/dev/null
diff -rq "$WORK/skills/statechart" "$ROOT/skills/statechart" >/dev/null

mkdir -p "$UPSTREAM/pstack/skills/unclassified"
printf '%s\n' '---' 'name: unclassified' 'description: New upstream skill.' '---' > "$UPSTREAM/pstack/skills/unclassified/SKILL.md"
git -C "$UPSTREAM" add pstack
git -C "$UPSTREAM" commit --quiet -m unclassified
printf '%s\n' "$(git -C "$UPSTREAM" rev-parse HEAD)" > "$WORK/UPSTREAM_COMMIT"

if PSTACK_UPSTREAM_REPO="$UPSTREAM" PSTACK_SKIP_FULL_CHECK=1 sh "$WORK/scripts/sync-upstream.sh" >/dev/null 2>&1; then
    echo 'sync accepted an unclassified upstream skill' >&2
    exit 1
fi
[ ! -e "$WORK/skills/unclassified" ]

rm -rf "$UPSTREAM/pstack/skills/unclassified"
printf '%s\n' '# Unclassified' > "$UPSTREAM/pstack/skills/poteto-mode/playbooks/unclassified.md"
git -C "$UPSTREAM" add pstack
git -C "$UPSTREAM" commit --quiet -m unclassified-playbook
printf '%s\n' "$(git -C "$UPSTREAM" rev-parse HEAD)" > "$WORK/UPSTREAM_COMMIT"

if PSTACK_UPSTREAM_REPO="$UPSTREAM" PSTACK_SKIP_FULL_CHECK=1 sh "$WORK/scripts/sync-upstream.sh" >/dev/null 2>&1; then
    echo 'sync accepted an unclassified upstream playbook' >&2
    exit 1
fi
[ ! -e "$WORK/skills/poteto-mode/playbooks/unclassified.md" ]

rm -f "$UPSTREAM/pstack/skills/poteto-mode/playbooks/unclassified.md"
printf '%s\n' '---' 'name: unclassified' 'description: New upstream agent.' '---' > "$UPSTREAM/pstack/agents/unclassified.md"
git -C "$UPSTREAM" add pstack
git -C "$UPSTREAM" commit --quiet -m unclassified-agent
printf '%s\n' "$(git -C "$UPSTREAM" rev-parse HEAD)" > "$WORK/UPSTREAM_COMMIT"

if PSTACK_UPSTREAM_REPO="$UPSTREAM" PSTACK_SKIP_FULL_CHECK=1 sh "$WORK/scripts/sync-upstream.sh" >/dev/null 2>&1; then
    echo 'sync accepted an unclassified upstream agent' >&2
    exit 1
fi
[ ! -e "$WORK/agents/unclassified.md" ]

rm -f "$UPSTREAM/pstack/agents/unclassified.md"
sed -i.bak 's/gives each group name a color class/names a color for each group/' "$UPSTREAM/pstack/skills/statechart/SKILL.md"
rm -f "$UPSTREAM/pstack/skills/statechart/SKILL.md.bak"
git -C "$UPSTREAM" add -A pstack
git -C "$UPSTREAM" commit --quiet -m statechart-conflict
printf '%s\n' "$(git -C "$UPSTREAM" rev-parse HEAD)" > "$WORK/UPSTREAM_COMMIT"

if PSTACK_UPSTREAM_REPO="$UPSTREAM" PSTACK_SKIP_FULL_CHECK=1 sh "$WORK/scripts/sync-upstream.sh" >/dev/null 2>"$FIXTURE/patch.err"; then
    echo 'sync accepted a patch that no longer applies' >&2
    exit 1
fi
grep -q 'patches/statechart.patch no longer applies' "$FIXTURE/patch.err"
diff -rq "$WORK/skills/statechart" "$ROOT/skills/statechart" >/dev/null

echo 'ok: pinned transactional upstream sync policy'
