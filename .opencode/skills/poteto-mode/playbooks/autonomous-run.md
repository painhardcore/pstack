### Autonomous run

**You own the exit condition. Define done, then drive to it without stopping.** Use for "going to bed", "run until done", or any request to continue until a checkable result.

1. State the exit condition as a checkable predicate before the first iteration (tests green, repro fixed, all N PRs merged, pixel-diff zero). A vague goal stalls; a predicate lets you stop.
2. Pick the active host's wait, monitor, automation, or recurring-task mechanism. Prefer an event wake for CI, merges, and ref changes. Use a time-based heartbeat only as a fallback. If the host has no continuation mechanism, complete as many iterations as the current run permits and leave a precise resumable checkpoint.
3. Each iteration makes the smallest change the evidence justifies, verifies it against the predicate, commits if it advanced, discards changes that didn't help. Belt-and-suspenders that "might help" gets reverted, not left to ride.
   Sequence the work via the **sequence-verifiable-units** principle skill, verifying each unit before the next instead of batching checks at the end.
4. Mid-run discoveries are yours when they remain inside scope. Address broken verification, related in-scope bugs, flaky checks, review noise, and tooling failures. Keep unrelated fixes separate. Surface irreversible actions, external authority needs, genuine product choices, and real dead ends. Return to the predicate after each side fix.
5. Checkpoint every iteration via the **show-me-your-work** skill, a row for what changed and whether the predicate moved. A run with no trail can't be audited or resumed.
6. Stop when the predicate is met. A plateau is not a stop, so keep going and pivot your approach to push past it. Surface a genuine dead end rather than spinning, and never relax the predicate to declare victory.

**Reply:** the exit condition, iterations run, what landed, what was discarded, final predicate state.
