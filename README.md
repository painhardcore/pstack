# pstack

pstack is a portable adaptation of [Cursor's pstack plugin](https://github.com/cursor/plugins/tree/main/pstack) for Codex, Claude Code, and OpenCode.

The distribution contains 41 skills, 19 playbooks, and host-specific agent definitions for Claude Code and OpenCode. Cursor-only workflows are intentionally omitted.

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

Copy the OpenCode package into a project:

```bash
cp -R /path/to/pstack/.opencode /path/to/project/
```

For user-wide installation, copy `.opencode/skills/` to `~/.config/opencode/skills/` and `.opencode/agents/` to `~/.config/opencode/agents/`.

Ask OpenCode to use the `poteto-mode` skill.

### Cursor

Install the [original plugin](https://github.com/cursor/plugins/tree/main/pstack). This fork does not package Cursor-only commands, cloud-agent workflows, transcript paths, or model rules.

## What is included

The 20 direct skills are:

- `poteto-mode`, `how`, `why`, `recall`, `blast-radius`, `architect`
- `arena`, `swarm`, `interrogate`, `teach`, `tdd`, `no-comments`
- `typescript-best-practices`, `figure-it-out`, `show-me-your-work`
- `create-verification-skill`, `maintain-verification-skill`
- `unslop`, `bro`, `technical-writing`

The other 21 skills are the `principle-*` rules used by those workflows.

The 19 playbooks cover investigation, bug fixing, performance, hillclimbing, runtime and trace forensics, features, refactoring, prototypes, visual parity, skill authoring, evals, pull-request babysitting, autonomous runs, session pickup, safe pauses, multi-phase plans, worktree cleanup, and opening pull requests.

Every delegation workflow has an inline fallback. The skills inherit the parent model unless the active host supports model selection and the workflow benefits from model diversity.

## What is omitted

The adaptation removes these upstream skills:

- `automate-me`
- `reflect`
- `setup-pstack`

It also removes these playbooks:

- `autopilot-full`
- `autopilot-stack`
- `orchestrate`
- `shipping`

Their current implementations depend on Cursor transcript storage, Cursor model rules, Cursor cloud agents, or Graphite. `figure-it-out`, `show-me-your-work`, `autonomous-run`, `babysit`, and the host's native Git workflow cover the portable parts.

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

The release gate verifies skill frontmatter, links, the OpenCode mirror, manifests, agent definitions, adapter behavior and idempotency, helper references, portable-token policy, and manifest version consistency.

## Sync upstream

`UPSTREAM_COMMIT` pins the reviewed Cursor plugin revision. The sync command fetches that exact commit, imports only policy-approved paths, runs the adapter, refreshes the OpenCode mirror, and runs the release gate.

```bash
./scripts/sync-upstream.sh
```

See [UPSTREAM_SYNC.md](UPSTREAM_SYNC.md) for the policy and update procedure.

## Guide

Read [the host-neutral guide](docs/guide/README.md) for invocation, workflow selection, and project skill paths.

## License

MIT. See [LICENSE](LICENSE). Original pstack work is credited through the upstream repository and license.
