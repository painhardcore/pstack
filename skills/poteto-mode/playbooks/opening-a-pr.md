### Opening a PR

Invoked at the end of every other playbook.

Opening a pull request changes external state. Do it only when the user authorized that action. Otherwise prepare the local branch, commits, and description, then report what remains.

**Worktree.** Work from a git worktree off main; subagents inherit it. Multiple subagent calls on the same branch each get their own worktree. If you must reuse one worktree between subagent calls, only `git fetch && git reset --hard origin/<branch>` when that worktree has no uncommitted or untracked work (`git status --porcelain` is empty); otherwise stop and ask, or open a fresh worktree. Dirty branch with unrelated work: patch out, fresh worktree, apply. Snarled worktree: reset from main, redo minimally.

**Commits.** Commit liberally. Rebase into small, ordered commits before opening PRs. Each commit is a future PR: landable, ordered to tell the story. Amend when the fix belongs in a just-made commit. New commit when separable. Commit bodies don't restate the subject.

**PRs.** Run **no-comments** over the diff before review. Write every pull-request title, description, and commit body with **technical-writing**, then apply **unslop**. Apply every technical-writing layer except Diátaxis. Use one word for each action, keep articles, and avoid `-ing` when a plain verb works.

**Titles.** Conventional Commits `type(scope): subject`, no trailing period. Type such as `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, or `perf`. Scope is the area, such as `pstack` or `poteto-mode`. Subject is short, imperative, and names a real symbol when one carries the change, for example `fix(pstack): retarget opening-a-pr babysit trigger`.

**Descriptions.** The PR body is a one-minute briefing, not a lab notebook, for a reviewer who has the diff. It says why the change exists, what it leaves out, what it could break, and how you proved it works. Write short, simple sentences with few identifiers, no walls of text. The body becomes the squash commit body, so keep that commit under about 40 lines. Use `##` headings, not bold lead-ins, in this order, and drop a section with nothing to say:

- `## Why`. The problem and approach in 1-3 short sentences, opening with the user's goal. No SHAs, rebase genealogy, or "based on main" preamble.
- `## What changed`. 1-3 short bullets. Name a real symbol or path only when it carries the change. Name both sides of a rename or retarget.
- `## Scope`. Always. 1-3 short items on what it covers and what it deliberately leaves out, such as a follow-up or a known gap. No file-by-file essay.
- `## Tradeoffs`. Only rejected alternatives a reviewer would otherwise ask about. Skip this section when there was no real choice.
- `## Blast Radius`. 1-2 sentences on who or what the change touches and why that is safe or risky. If main is red without the fix, name the cost of leaving it red.
- `## Verification`. 1-3 bullets, each a real run path, such as `manual CLI testing`, `manual UI testing`, or the targeted tests, and its outcome. For perf, give one primary number with its unit as `before → after`, and link the notes or artifact that hold the runs. No sample-size methodology or metric tables.

After the sections, attach videos or screenshots when they prove a claim. Full SHAs, swarm or arena lane recitals, lever-correction essays, file-by-file checklists, and "CLEAN" verdicts go in a linked artifact, not the body.

**Size and stacks.** Prefer several narrow pull requests to one large pull request when each unit lands independently. A stack is a base-branch chain. The root pull request targets trunk. Each child branch rebases onto its parent's exact tip, and its pull request targets the parent branch. Keep the order visible in each description. Branch from the default branch for independent work and rebase before substantial follow-up work.

**Hosting service.** Resolve the hosting service and its CLI or connector before the first pull-request operation, and keep that choice for create, edit, view, watch, and merge. On GitHub, `gh` is the default. When the host provides a built-in pull-request tool, create, edit, retarget, and mark ready through it, and use the CLI only for what the tool does not cover.

**Readiness.** Open every pull request ready unless the user asked for a draft. A built-in tool can default to draft, so set the ready state explicitly. Check the created pull request with the hosting service before referring to its status.

**Babysit.** Opening a pull request does not start a babysit. Post the URL and keep building. Finish the phase or stack first, and run a separate babysit pass only when the user asks for one. A babysit for each new pull request stalls the build and spends checks on commits that later waves restart.

A subagent that opens a pull request runs **interrogate**, **unslop**, and **no-comments** first. It returns the URL and does not babysit. Return to the parent.
