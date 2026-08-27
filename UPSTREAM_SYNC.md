# Sync from Cursor pstack

This repository tracks one reviewed revision of [cursor/plugins/pstack](https://github.com/cursor/plugins/tree/main/pstack). `UPSTREAM_COMMIT` contains the full commit SHA.

## Policy

`upstream-policy.tsv` classifies every upstream item:

- `sync` copies a host-neutral skill automatically.
- `adapt` preserves the local portable version for manual comparison.
- `skip` removes a Cursor-only skill or playbook from the distribution.

The sync stops before changing live files when upstream adds or removes an unclassified skill, playbook, or agent.

## Update the pin

1. Resolve the exact upstream commit to review.
2. Replace the SHA in `UPSTREAM_COMMIT`.
3. Run the sync.

```bash
./scripts/sync-upstream.sh
```

The script:

1. Fetches only the pinned commit into a temporary repository.
2. Verifies every upstream skill, playbook, and agent against `upstream-policy.tsv`.
3. Starts from the current portable distribution.
4. Imports only entries marked `sync`.
5. Runs the adapter and content validator in the temporary tree.
6. Replaces the live skill, agent, and guide trees only after that candidate passes.
7. Refreshes `.opencode/skills/` and runs `make check`.

## Review adapted entries

For every `adapt` entry changed upstream, compare the upstream file at the pinned SHA with the local file. Port behavior and rationale, not host-specific syntax.

Portable instructions must:

- Use the host's native tools instead of named tool fields.
- Inherit the parent model by default.
- Include an inline path when subagents are unavailable or forbidden.
- Use documented project skill paths for Codex, Claude Code, and OpenCode.
- Keep pushes, pull requests, merges, deployments, messages, and remote deletion behind explicit authority.

`make check` runs the adapter fixture twice and fails if the second run changes the result.

## Add an upstream item

Add one row to `upstream-policy.tsv` before syncing:

```text
kind	name	action
skill	new-skill	adapt
```

Choose `sync` only when the file contains no host-specific paths, commands, model identifiers, or tool syntax. Choose `skip` when the workflow cannot operate without Cursor-only infrastructure.

## Release checklist

1. Review every changed `adapt` entry.
2. Run `make check`.
3. Update `CHANGELOG.md`.
4. Bump all three manifest versions together.
5. Commit the new `UPSTREAM_COMMIT` with the adapted changes.
