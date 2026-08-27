# Changelog

## [1.1.0] - 2026-08-27

- Replaced the failing `sed` adapter with an atomic, idempotent Python adapter and behavioral tests.
- Pinned upstream synchronization and added an explicit sync, adapt, or skip policy for every upstream skill, playbook, and agent.
- Removed Cursor-only skills and playbooks from the portable distribution.
- Rewrote delegated workflows to use host-native tools, inherit the parent model, and run inline when subagents are unavailable.
- Corrected project skill paths, agent metadata, Codex capabilities, invocation documentation, and release validation.

## [1.0.0] - 2026-08-23

- Published the initial multi-host adaptation.
