### Worktree and simulator cleanup

**You own the disk and the safety gate.** Prune merged or abandoned git worktrees and stale iOS simulators to reclaim space. Deletion is irreversible, so every step guards against deleting something in use or holding uncommitted work.

1. Snapshot and audit. Record `df -h /`. Read every path from `git worktree list --porcelain`; never type candidate paths from memory. For each worktree, record size, branch, age, merge state, `git status --porcelain`, and related pull-request state when available.
2. The classification is advice, not permission. Cross-check candidates against active tasks, processes, terminals, and worktrees that the user identified as in use. If the host exposes task-to-worktree state, inspect it. Never scan unrelated private transcripts.
3. Verify uncertain usage before deleting. A worktree with a running process, active task, open uncommitted edit, or unclear owner stays.
4. Pause on irreversible loss. `wip:N` is N tracked uncommitted edits. Show the diff and get a decision first, since removing a clean worktree is recoverable from its branch but uncommitted work is gone. `scratch:N` is untracked throwaway; name the files and get explicit human confirmation before removing anything untracked, since that content has no branch to recover from. Per Autonomy, clean and merged and not-in-use proceeds; `wip` and in-use pause.
5. Prune the confirmed set. Per path, `git worktree remove --force <path>`; if the dir survives on ignored build artifacts, `rm -rf` it, then `git worktree prune`. Branch refs survive, so no commits are lost. Confirm with `df -h /` and re-list.
6. Simulators and other reclaimers. On macOS, inspect `xcrun simctl list` before deleting unavailable simulators or old runtimes. Inspect Xcode build data and package-manager caches only when the user included them in scope. Clear only explicit, verified targets.

This is the one playbook that deletes user state with no code review to catch a slip, so the gates above are the review.

**Reply:** `df -h /` before and after with space reclaimed, the worktrees pruned, and a one-line reason for each held back (in-use by which chat, or uncommitted work).
