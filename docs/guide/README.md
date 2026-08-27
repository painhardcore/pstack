# Use pstack

pstack packages portable engineering workflows for Codex, Claude Code, and OpenCode. Install the package for one host, start a new session, then ask that host to use `poteto-mode` for a non-trivial task.

## Invoke a skill

| Host | Explicit invocation |
|---|---|
| Codex | Type `$`, select `pstack:poteto-mode`, and add the task. |
| Claude Code | Run `/pstack:poteto-mode <task>`. |
| OpenCode | Ask it to use the `poteto-mode` skill. |

Every host can also select a skill implicitly from its `description`.

## Give a checkable request

Name the symptom or outcome and the proof that ends the work.

```text
Use poteto-mode. The export writes duplicate rows when a retry lands mid-run. Reproduce it, fix the shared cause, and run the regression check.
```

`poteto-mode` chooses a playbook, copies its steps into the task list, and loads the principle skills that affect the work.

## Understand before editing

- Use `how` for code paths, data flow, ownership, and architecture.
- Use `why` for historical rationale and external constraints.
- Use `recall` to rebuild recent working context from history the host can access.
- Use `blast-radius` before a small change with uncertain downstream impact.

All delegation skills include an inline fallback. A host without subagents or per-subagent model selection still runs the workflow.

## Build and verify

- Use `architect` before a change crosses a boundary.
- Use `arena` for competing designs.
- Use `swarm` for independent coverage slices.
- Use `tdd` for a cheap local regression test.
- Use `create-verification-skill` when the project lacks a user-level verification workflow.
- Use `no-comments`, `technical-writing`, and `unslop` before review.

External actions still require authority. A request to edit or review does not authorize a push, pull request, merge, deployment, message, or ticket update.

## Project verification-skill paths

| Host | Path |
|---|---|
| Codex | `.agents/skills/` |
| Claude Code | `.claude/skills/` |
| OpenCode | `.opencode/skills/` |

Create one copy for the active host. Do not maintain three generated copies inside an application repository.

## Cursor

This fork intentionally omits workflows tied to Cursor cloud agents, Cursor transcript storage, Cursor model rules, Graphite, and Cursor-only commands. Install the [upstream Cursor plugin](https://github.com/cursor/plugins/tree/main/pstack) when you need those workflows.
