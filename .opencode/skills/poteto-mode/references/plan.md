# Multi-phase plan contract

Write a plan that another agent can execute without rediscovering the repository.

## Grounding

State the goal, current behavior, target behavior, scope, and constraints. Link the files and symbols that establish each fact. Ask the user only for product intent, preference, authority, or information the repository cannot provide.

Capture a baseline before changing anything. The baseline must use the same command, artifact, or user path that will verify completion.

## Phase shape

Each phase contains:

1. One checkable outcome.
2. The files or subsystem it owns.
3. Dependencies on earlier phases.
4. The smallest safe implementation unit.
5. The exact verification command or artifact.
6. The rollback or stop condition.

Order phases so scaffolding and risky unknowns come first. Remove obsolete paths before adding replacements. Keep every phase independently reviewable and green.

## Delegation

Use subagents only when the host supports them, the user permits them, and work has disjoint writable targets. Inherit the parent model. Give each worker a separate worktree, branch, or temporary directory.

If subagents are unavailable or forbidden, execute the same phases inline. Keep skipped delegation steps in the task list with their reason.

## Authority

Local reading, editing, and verification can proceed inside the user's scope. Pushes, pull requests, merges, deployments, messages, tickets, and remote deletion require explicit authority.

## Completion

Finish every phase with its own check. Then run the full baseline-to-target verification on the real artifact. Update the plan when evidence changes the work. Do not edit old claims to hide a pivot; record the new decision.
