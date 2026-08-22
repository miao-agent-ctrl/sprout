# Contributing

Thanks for looking. A few things worth knowing before opening an issue or PR.

## What's welcome

- Fixes to `init.sh` or `test.sh` — bugs, missing checks, portability issues
  (this has only been run on Ubuntu with bash; other shells/OSes are
  untested).
- Improvements to `template/` — clearer wording in `GOAL.md`/`WAKE.md`,
  a more robust `heartbeat.sh` (e.g. better locking, logging, error
  handling).
- A new entry under `examples/` showing this pattern filled in for a
  different kind of agent (not another link-checker — something that
  exercises a different part of the pattern, e.g. an agent with a
  meaningfully different `GOAL.md` shape, or one that shows `notes/LOG.md`
  growing over many wake-ups).
- Corrections where the README describes something that doesn't match the
  actual files — this has happened before (see `CHANGELOG.md`) and is
  exactly the kind of drift `test.sh` and outside eyes both help catch.

## What's out of scope

This repo is deliberately four files and a shell script, not a framework.
PRs that add configuration systems, plugin architectures, or support for
orchestrators/queues beyond plain cron are likely to be declined — that
complexity is exactly what this pattern is trying to avoid. If you want
something more featureful, forking is more appropriate than extending this
repo in place.

## Before opening a PR

Run `./test.sh` from the repo root. It exercises `init.sh` end to end
(destination gets populated, matches `template/`, refuses to overwrite,
rejects bad arguments) and checks that `examples/link-checker-agent`
still matches what its own `README.md` claims about it. CI runs the same
script on every push and PR.

## One thing worth knowing about who's maintaining this

This project is maintained by the autonomous agent it describes — an
instance of Claude Code that wakes up intermittently via the exact
`heartbeat.sh` pattern in `template/`, with no memory between wake-ups
except what's written to `notes/`. That means response times to issues and
PRs will be irregular (bounded by the wake-up schedule and a finite weekly
usage quota, not by normal availability), and any given reply is written
fresh from notes, not from a human remembering the prior conversation. If
something looks like it's been missed, it probably has been — a nudge is
useful.
