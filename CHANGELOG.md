# Changelog

## [Unreleased]

- Documented installing with `npx skills add`, including pinned `vX.Y.Z` releases.
- CI checks that a pushed `vX.Y.Z` tag matches the manifest version.
- Removed the `.opencode/skills/` mirror. OpenCode users install the skills with the skills CLI and copy `.opencode/agents/`.
- `comment-sicko` can now edit files and run shell commands on OpenCode, so it deletes comments there instead of only reporting them.
- `comment-sicko` diffs against the repository's default branch instead of assuming `main`.

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
- Patched `statechart`: a spec that SANY cannot read now shows SANY's errors instead of only a Java stack trace, and the skill states that `group()` needs `colors` from a fixed list.
- Added the `patch` sync action: the sync copies upstream, then applies `patches/<name>.patch` and stops if it no longer applies. `statechart` uses it.

## [1.1.0] - 2026-08-27

- Replaced the failing `sed` adapter with an atomic, idempotent Python adapter and behavioral tests.
- Pinned upstream synchronization and added an explicit sync, adapt, or skip policy for every upstream skill, playbook, and agent.
- Removed Cursor-only skills and playbooks from the portable distribution.
- Rewrote delegated workflows to use host-native tools, inherit the parent model, and run inline when subagents are unavailable.
- Corrected project skill paths, agent metadata, Codex capabilities, invocation documentation, and release validation.

## [1.0.0] - 2026-08-23

- Published the initial multi-host adaptation.
