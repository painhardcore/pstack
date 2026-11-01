# Changelog

## [1.2.0] - 2026-11-01

- Synced upstream pstack to `cursor/plugins@ae5650f`.
- Added portable skills: `benchmark-checklist`, `correct`, `create-formal-verification-skill`, `maintain-formal-verification-skill`, `statechart`, `in-your-own-words`, `sharpen`, `ketchup`, and `ketchup-video`.
- Added principles: `principle-attack-the-premise`, `principle-explain-the-number`, and `principle-test-behavior-not-implementation`.
- Rewrote `interrogate` so adversaries prove each finding with a run and the lead keeps only findings that a rerun confirms. Removed the reviewer and rubric references.
- Simplified `how` to an explore-then-explain flow and removed its critique mode. Trimmed `why`.
- Ported upstream `poteto-mode` changes: restate the user's goal first, prefer fresh subagents, match reasoning level to the job, and label every claim as measured, inferred, or a guess.
- Ported upstream playbook changes, including performance mantras, benchmark vetting, the shorter pull-request body, and regression checks against trunk in multi-phase plans.
- Made `poteto-agent` a delegate for playbook steps rather than the runner.
- Omitted the Cursor-only `make-bot-ui` and `poteto-help` skills.
- The adapter now drops Cursor's fast-or-standard model speed wording, and the validator rejects current Cursor model slugs.

## [1.1.0] - 2026-08-27

- Replaced the failing `sed` adapter with an atomic, idempotent Python adapter and behavioral tests.
- Pinned upstream synchronization and added an explicit sync, adapt, or skip policy for every upstream skill, playbook, and agent.
- Removed Cursor-only skills and playbooks from the portable distribution.
- Rewrote delegated workflows to use host-native tools, inherit the parent model, and run inline when subagents are unavailable.
- Corrected project skill paths, agent metadata, Codex capabilities, invocation documentation, and release validation.

## [1.0.0] - 2026-08-23

- Published the initial multi-host adaptation.
