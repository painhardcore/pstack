# Changelog

## [Unreleased]

- Added `unslop-fr`, a French companion to `unslop`. It covers French AI tells, English calques, formal letters, and orthotypography, with references and a sources file that records what the research could not verify.
- Added a `local` action to `upstream-policy.tsv` for skills with no upstream file. The sync now preserves them and refuses an upstream item that collides with one.
- Pointed `unslop` and `poteto-mode` at `unslop-fr` for French prose.

## [1.1.0] - 2026-08-27

- Replaced the failing `sed` adapter with an atomic, idempotent Python adapter and behavioral tests.
- Pinned upstream synchronization and added an explicit sync, adapt, or skip policy for every upstream skill, playbook, and agent.
- Removed Cursor-only skills and playbooks from the portable distribution.
- Rewrote delegated workflows to use host-native tools, inherit the parent model, and run inline when subagents are unavailable.
- Corrected project skill paths, agent metadata, Codex capabilities, invocation documentation, and release validation.

## [1.0.0] - 2026-08-23

- Published the initial multi-host adaptation.
