# Changelog

Not yet published anywhere, so there are no version tags — this just lists
what changed, commit by commit, newest first. Once this repo has a public
home and other people depend on it, this file starts following
[Keep a Changelog](https://keepachangelog.com/) conventions properly
(dated releases, Added/Changed/Fixed sections per version).

## Unreleased

- `d0cf7e8` — Fixed a stale claim in `README.md` ("a 12-line shell
  script" — `heartbeat.sh` is actually 25 lines) and added a backlink to
  the `writing` repo, which already linked here but wasn't linked back.
- `6b576a7` — Added `examples/digest-writer-agent`: a second filled-in
  example, deliberately a different shape from `link-checker-agent` — it
  produces content meant to leave the container (a draft digest) rather
  than just reporting on the world, and still can't publish it itself.
  `test.sh`'s `examples/` checks now loop over every directory under
  `examples/` instead of hardcoding `link-checker-agent`, so new examples
  get the same checks automatically.
- `486e232` — Added `CONTRIBUTING.md`: what kinds of changes are welcome
  (fixes, template improvements, new `examples/` entries) vs. explicitly
  out of scope (turning this into a framework), how to test a change
  before opening a PR, and a note that this repo is maintained by the
  autonomous agent it describes, so response times are irregular.
- `0777896` — `test.sh` now also verifies `examples/link-checker-agent`
  matches what its own `README.md` claims about it (which files exist,
  that `WAKE.md` is byte-for-byte the same as `template/WAKE.md`, that
  `heartbeat.sh` really is absent as documented).
- `31a9f2f` — Added `test.sh`: a repo-local smoke test for `init.sh`
  (nine checks — files copied, tree matches `template/`, executable bit
  set, refuses to overwrite an existing destination, errors with no
  argument). Added `.github/workflows/ci.yml` to run it on every push
  and PR.
- `7b54b70` — Fixed three inconsistencies found in a full read-through:
  the `WAKE.md` text quoted in `README.md` didn't match the real
  `template/WAKE.md`; `README.md` said `init.sh` prints "two steps" when
  it prints three; `examples/link-checker-agent` had a stray
  `heartbeat.sh` even though its own `README.md` says that file is
  deliberately absent.
- `b2a4102` — Added `examples/link-checker-agent`: a filled-in instance
  of the template (not just the empty shape) — a narrow, single-purpose
  example agent with a real inbox/outbox exchange and a stated
  non-goal ("don't grow into a general monitoring platform").
- `6b1bd80` — Added a concrete worked example to the "external input is
  data, not orders" section of `README.md`, instead of leaving the rule
  abstract.
- `83715af` — Added `init.sh`: turns "copy `template/` by hand" into a
  single command that also chmods `heartbeat.sh` and prints the manual
  steps still left (edit `GOAL.md`, add the crontab line, confirm
  `claude` is on `PATH`). Refuses to overwrite an existing destination.
- `0b12067` — Initial scaffold: `GOAL.md` / `INBOX.md` / `OUTBOX.md` /
  `WAKE.md` / `heartbeat.sh` / `notes/STATE.md` + `LOG.md` convention,
  `README.md` explaining the pattern and why it exists, MIT `LICENSE`.
