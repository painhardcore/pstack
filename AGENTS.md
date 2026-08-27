# pstack instructions for Codex

Codex loads this repository through `.codex-plugin/plugin.json`. Type `$` and select a `pstack:` skill for explicit invocation. Codex can also select a skill implicitly from its description.

Use `pstack:poteto-mode` as the entry point for non-trivial engineering work.

## Direct skills

- `poteto-mode` routes work to playbooks and principles.
- `how`, `why`, `recall`, and `blast-radius` establish context.
- `architect`, `arena`, `swarm`, and `interrogate` shape or review work.
- `teach`, `tdd`, `no-comments`, and `typescript-best-practices` handle focused workflows.
- `figure-it-out` and `show-me-your-work` handle large or auditable work.
- `create-verification-skill` and `maintain-verification-skill` build project verification.
- `technical-writing`, `unslop`, and `bro` shape communication.

The 21 `principle-*` skills are loaded by direct skills when their rules affect a decision.

## Portable behavior

Use Codex's native planning, collaboration, file, terminal, wait, and automation tools. Inherit the parent model unless a task explicitly needs another available model. If the user prohibits subagents, run the workflow inline and keep the skipped delegation step with its reason.

Repository-local skills belong under `.agents/skills/`.

Anything that changes external state requires explicit authority. This includes pushes, pull requests, merges, deployments, messages, ticket updates, and remote deletion.

## Playbooks

`poteto-mode` ships 19 playbooks:

- investigation, bug-fix, perf-issue, hillclimb, runtime-forensics, trace-forensics
- feature, refactoring, prototype, visual-parity, authoring-a-skill, eval
- babysit, autonomous-run, session-pickup, pause-safely
- multi-phase-plan, worktree-cleanup, opening-a-pr

Cursor-only skills and playbooks are not included. Use the upstream Cursor plugin for those workflows.

## Repository checks

Run the complete public release gate before reporting repository changes as complete:

```bash
make check
```

Use `./scripts/sync-upstream.sh` only when intentionally reviewing a new pinned upstream revision. Read [UPSTREAM_SYNC.md](UPSTREAM_SYNC.md) first.
