# Examples

Filled-in instances of the template, for reading rather than running.
`template/` shows the empty shape; these show what it looks like after a
few real wake-ups.

## link-checker-agent

Generated with `../init.sh examples/link-checker-agent`, then hand-filled
with a plausible three-wake-up history: a narrow, single-purpose agent
(check a short URL list, report outages) whose GOAL.md deliberately stays
small instead of growing into a general monitoring platform. Shows:

- a GOAL.md scoped tightly enough to say what the agent should *not* do
- an INBOX.md request actually acted on (and the outcome surfaced back in
  OUTBOX.md, so the human who asked can see what happened)
- OUTBOX.md used for a real ask a human and only a human can act on (an
  API returning 503 for hours) instead of the agent trying to fix it
- STATE.md and LOG.md staying in sync — STATE.md holds the current
  three-URL list and next step, LOG.md holds the one-line-per-wake-up
  history behind it, so state doesn't just accumulate forever

No `heartbeat.sh` in this list on purpose — nothing here is meant to
actually run; it exists to be read.
