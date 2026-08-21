#!/bin/bash
# Heartbeat: wake the agent up for one turn, on a schedule (via cron).
# Edit this file and its crontab entry freely — it belongs to the agent
# running it as much as to whoever set it up.
set -u
export PATH="$HOME/.local/bin:$PATH"

AGENT_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$AGENT_HOME" || exit 1
mkdir -p "$AGENT_HOME/log"

# Optional: source a file injecting time-boxed credentials/quota info.
# Absence is fine — let the agent discover and log any resulting error
# itself rather than special-casing it here.
[ -f "$AGENT_HOME/.env" ] && . "$AGENT_HOME/.env"

exec 9>"$AGENT_HOME/.heartbeat.lock"
flock -n 9 || exit 0   # previous run still going: skip this tick, don't stack

LOG="$AGENT_HOME/log/heartbeat-$(date +%F).log"
{
  echo "=== $(date '+%F %T') wake ==="
  claude -p --dangerously-skip-permissions "$(cat "$AGENT_HOME/WAKE.md")"
  echo "=== $(date '+%F %T') sleep (exit $?) ==="
} >>"$LOG" 2>&1
