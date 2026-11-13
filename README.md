# pstack

pstack is a portable adaptation of [Cursor's pstack plugin](https://github.com/cursor/plugins/tree/main/pstack) for Codex, Claude Code, and OpenCode.

The distribution contains 53 skills, 19 playbooks, and host-specific agent definitions for Claude Code and OpenCode. Cursor-only workflows are intentionally omitted.

## Install

### Codex

```bash
codex plugin marketplace add painhardcore/pstack
codex plugin add pstack@pstack
```

Start a new Codex session. Type `$`, select `pstack:poteto-mode`, and add the task. Codex can also select a pstack skill implicitly from its description.

### Claude Code

```text
/plugin marketplace add painhardcore/pstack
/plugin install pstack@pstack
```

Start a new session, then run `/pstack:poteto-mode <task>`.

### OpenCode

Install the skills with the [skills CLI](#any-agent-with-the-skills-cli):

```bash
npx skills add painhardcore/pstack --skill '*' -a opencode
```

Then copy the agents into the project's `.opencode/agents/`, or into `~/.config/opencode/agents/` for every project:

```bash
mkdir -p .opencode/agents
cp /path/to/pstack/.opencode/agents/*.md .opencode/agents/
```

Ask OpenCode to use the `poteto-mode` skill.

### Any agent with the skills CLI

The [skills CLI](https://github.com/vercel-labs/skills#readme) installs pstack for any agent that supports [Agent Skills](https://agentskills.io/specification), including Claude Code, Codex, Cursor, and OpenCode. It needs Node.js. Run it in the project that should get the skills:

```bash
# Latest master
npx skills add painhardcore/pstack --skill '*'

# A pinned release
npx skills add painhardcore/pstack@v1.2.0 --skill '*'
```

Pick your agent at the prompt, or pass `-a claude-code`, `-a codex`, and so on. Add `-g` to install for all your projects.

An unpinned install follows `master`. `npx skills check` reports new commits and `npx skills update` installs them. A pinned install stays on its tag, and `skills update` never moves it. To upgrade, run `skills add` again with the new tag. Each release tag `vX.Y.Z` matches the plugin version.

Compared with the plugin install:

- Install every skill with `--skill '*'`. The workflow skills load the `principle-*` skills and link to files in other skills, so a partial install breaks them.
- Skills install under plain names, such as `/poteto-mode` or `$poteto-mode`, instead of `pstack:poteto-mode`. Short names such as `how`, `why`, `tdd`, and `teach` can collide with other installed skills.
- The CLI does not install the `poteto-agent` and `comment-sicko` agents. The skills run those steps inline instead.

### Cursor

Install the [original plugin](https://github.com/cursor/plugins/tree/main/pstack). This fork does not package Cursor-only commands, cloud-agent workflows, transcript paths, or model rules.

## What is included

The 29 direct skills are:

- `poteto-mode`, `how`, `why`, `recall`, `blast-radius`, `architect`
- `arena`, `swarm`, `interrogate`, `teach`, `tdd`, `no-comments`
- `typescript-best-practices`, `figure-it-out`, `show-me-your-work`
- `create-verification-skill`, `maintain-verification-skill`
- `create-formal-verification-skill`, `maintain-formal-verification-skill`, `statechart`
- `benchmark-checklist`, `correct`, `in-your-own-words`, `sharpen`
- `ketchup`, `ketchup-video`
- `unslop`, `bro`, `technical-writing`

The other 24 skills are the `principle-*` rules used by those workflows.

The 19 playbooks cover investigation, bug fixing, performance, hillclimbing, runtime and trace forensics, features, refactoring, prototypes, visual parity, skill authoring, evals, pull-request babysitting, autonomous runs, session pickup, safe pauses, multi-phase plans, worktree cleanup, and opening pull requests.

Every delegation workflow has an inline fallback. The skills inherit the parent model unless the active host supports model selection and the workflow benefits from model diversity.

## What is omitted

The adaptation removes these upstream skills:

- `automate-me`
- `make-bot-ui`
- `poteto-help`
- `reflect`
- `setup-pstack`

It also removes these playbooks:

- `autopilot-full`
- `autopilot-stack`
- `orchestrate`
- `shipping`

Their current implementations depend on Cursor transcript storage, Cursor model rules, Cursor cloud agents, Cursor routines and webhooks, Cursor's setup flow, or Graphite. `figure-it-out`, `show-me-your-work`, `autonomous-run`, `babysit`, and the host's native Git workflow cover the portable parts.

## Project verification skills

`create-verification-skill` writes one project-local skill for the active host:

| Host | Project skill root |
|---|---|
| Codex | `.agents/skills/` |
| Claude Code | `.claude/skills/` |
| OpenCode | `.opencode/skills/` |

## Verify the repository

```bash
make check
```

The release gate verifies skill frontmatter, links, manifests, agent definitions, adapter behavior and idempotency, helper references, portable-token policy, and manifest version consistency. On a `vX.Y.Z` tag push, CI also checks that the tag matches the manifest version.

## Sync upstream

`UPSTREAM_COMMIT` pins the reviewed Cursor plugin revision. The sync command fetches that exact commit, imports only policy-approved paths, runs the adapter and the release gate.

```bash
./scripts/sync-upstream.sh
```

See [UPSTREAM_SYNC.md](UPSTREAM_SYNC.md) for the policy and update procedure.

## Guide

Read [the host-neutral guide](docs/guide/README.md) for invocation, workflow selection, and project skill paths.

## License

MIT. See [LICENSE](LICENSE). Original pstack work is credited through the upstream repository and license.
