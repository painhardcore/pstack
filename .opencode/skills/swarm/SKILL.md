---
name: swarm
description: "Fan out N independent workers, collect their results, and return one report for coverage, races, gauntlets, or exploration."
---

# Swarm

## Start

Open a todolist with one entry per phase before launching anything.

1. Frame
2. Fan out
3. Aggregate
4. Report

## Phase A: Frame

1. State the done predicate and the artifact or report the swarm must return.
2. Choose the shape. Partition into slices, race N workers on identical briefs, or mix both. For a race or mixed shape, declare `first pass`, `rank all`, or `best-of` before spawning.
3. Set N from the user or derive it from the shape. N is total workers, not a concurrency limit.
4. Inherit the parent model unless the host supports model selection and the race explicitly compares models. Name each model-race arm up front. If the host rejects a requested model, use the parent model and say so. Pick each subagent's reasoning level for the job, per the Subagents section of the **poteto-mode** skill.
5. Give each worker its own writable output when it writes. Use a worktree, branch, or `/tmp/swarm-<slug>/worker-<n>/`. When workers verify or measure commits, each brief names the exact SHAs. A measurement brief also names the method (sample count, what one sample is, order). The worker records both in its result.

## Phase B: Fan out

Use the host's native subagent tool to start all N workers concurrently, in the background when the host supports it. Prefer isolated remote or sandboxed workers when the host offers them, and keep a worker local only when it needs something on the user's computer. Give each worker the minimum file and tool access its slice needs. If subagents are unavailable or forbidden, run each slice inline and preserve the same result schema.

When a worker needs a non-default branch, name that branch in its brief and use an isolated checkout or worktree.

Every brief stands alone. Include the goal, scope, exact slice or race arm, how to verify, and what to report. Reports use `PASS`, `ISSUES`, or `BLOCKED` with evidence. A worker that can prove a defect reports `ISSUES` and lists every issue it can prove, not only the first.

If a worker drops out, proceed with N-1 and note it.

## Phase C: Aggregate

Read the terminal results. Drop a result that does not record the SHAs and method its brief names, and respawn that worker once. After a second miss, record a gap. A gap does not count as a pass. For coverage, every required slice needs a result. For a race, apply the selection rule declared up front. Use first pass, rank all, or best-of. Do not paste raw worker dumps.

## Phase D: Report

Return one consolidated in-chat report with a result table, issue one-liners, gaps or dropouts, and the race rule when used.
