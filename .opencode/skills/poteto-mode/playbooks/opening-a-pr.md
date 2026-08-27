### Opening a PR

Invoked at the end of every other playbook.

Opening a pull request changes external state. Do it only when the user authorized that action. Otherwise prepare the local branch, commits, and description, then report what remains.

**Worktree.** Work from a git worktree off main; subagents inherit it. Multiple subagent calls on the same branch each get their own worktree. If you must reuse one worktree between subagent calls, only `git fetch && git reset --hard origin/<branch>` when that worktree has no uncommitted or untracked work (`git status --porcelain` is empty); otherwise stop and ask, or open a fresh worktree. Dirty branch with unrelated work: patch out, fresh worktree, apply. Snarled worktree: reset from main, redo minimally.

**Commits.** Commit liberally; rebase into small, ordered commits before opening PRs. Each commit is a future PR: landable, ordered to tell the story. Amend when the fix belongs in a just-made commit; new commit when separable.

**PRs.** Run **no-comments** over the diff before review. Write every pull-request title, description, and commit body with **technical-writing**, then apply **unslop**. Apply every technical-writing layer except Diátaxis. Use one word for each action, keep articles, and avoid `-ing` when a plain verb works.

**Titles.** Use Conventional Commits in the form `type(scope): subject`. Use `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, or `perf` as the type. Use the changed area, such as `pstack` or `poteto-mode`, as the scope. Keep the subject short and imperative. Apply the same `/technical-writing` and `/unslop` pass as the body. Name a real symbol when one carries the change. For example, `fix(pstack): retarget opening-a-pr babysit trigger`. Do not add a trailing period.

**Descriptions.** Use these sections in order. Drop a section when it is empty.

- `## Why`. State the intent and why this approach fits.
- `## Scope`. State facts from the diff. Name real symbols and paths. Name both sides of a rename or retarget. State what is in and out when the boundary matters.
- `## Tradeoffs`. State real choices only. Skip this section when there are none.
- `## Blast Radius`. State who and what the change touches. Explain why the change is safe or risky. If main is red without the fix, name the continuing cost.
- `## Verification`. State how you ran each check and its rigor. Name the real path, such as `manual CLI testing`, `manual UI testing`, or the targeted tests. State the outcome of each check, not only the command name.

After these sections, attach videos or screenshots when they prove a claim. Do not use `## Summary` or `## Test plan` boilerplate. A commit body does not restate its subject.

**Size and stacks.** Prefer several narrow pull requests to one large pull request when each unit lands independently. Use the hosting service's native base branches for a stack. Keep the order visible in each description. Branch from the default branch for independent work and rebase before substantial follow-up work.

**Readiness.** Open every pull request ready unless the user asked for a draft. Check the created pull request with the hosting service before referring to its status.

**Babysit.** Opening a PR does not start a babysit. Post the URL and keep building. Finish the phase or stack first. Run a separate babysit pass only when the user asks for one after the whole stack exists. A babysit for each new PR stalls the build and spends checks on commits that later waves restart. Push back when feedback drifts from intent.

A subagent that opens a pull request runs **interrogate**, **unslop**, and **no-comments** first. It returns the URL and does not babysit. Return to the parent.
