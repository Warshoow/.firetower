# claude-worker-config

Claude Code config for the Firetower worker. Real files, no symlinks, no
paths tied to the dev machine.

## Install / update (on the worker, as the agents' account)

```sh
git clone <this repo> ~/claude-worker-config
~/claude-worker-config/install.sh              # add --graphify for the graphify CLI
```

Update: `cd ~/claude-worker-config && git pull && ./install.sh`.
Replaced files are backed up in `~/.claude/backups/worker-config-<date>/`.

## Contents

- `CLAUDE.md`, `RTK.md` — global rules.
- `agents/` — builder, debugger, tester, reviewer, reviewer-quick, scout, planner.
- `skills/` — decide-first, audit-360, checkpoint, show-me-your-work, behuman,
  graphify, gauntlet-loop.
- `hooks/` — big-read-gate.py, context-watch.sh.
- `settings.json` — the hooks above, rtk, plugins ponytail, mattpocock-skills,
  ui-ux-pro-max.

## Left out on purpose

- Laya logging rule: absolute path to the dev machine, and it would pool client
  code into a personal dataset.
- Windows/Orca hooks, statusline: no Windows, no Orca, no screen on the worker.
- visual-check, verify-setup, docker-maint, computer-use, orca-cli,
  orchestration, afk-*, recall, evolve, jira-standup, learn, coach-craft,
  prior-art, find-skills: tied to the dev machine, or need a person answering.
- devops agent: written around `~/projects-*` and the dev machine's mounts.
- marketing-skills, rust-analyzer-lsp plugins: not code work / needs a binary.
- Credentials, `.claude.json`, history, transcripts: login goes through
  `claude setup-token` in the Firetower app.

## Updating from the dev machine

Files here are copies. After changing a skill or agent on the dev machine,
copy it again, e.g. `cp -rL ~/.claude/skills/<name> claude/skills/`.
