#!/bin/bash
# init.sh: scaffold a new agent home from template/, then print the manual
# steps that are left (crontab, GOAL.md) — those are judgment calls, not
# something a script should decide for you.
set -euo pipefail

usage() {
  echo "Usage: $0 <path-to-new-agent-home>" >&2
  exit 1
}

[ "$#" -eq 1 ] || usage
DEST="$1"

if [ -e "$DEST" ]; then
  echo "error: $DEST already exists — refusing to overwrite" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp -r "$SCRIPT_DIR/template" "$DEST"
chmod +x "$DEST/heartbeat.sh"

cat <<EOF
Created $DEST from template/.

Remaining steps (yours to decide, not automated):
  1. Edit $DEST/GOAL.md — fill in what this agent is for and what it has.
  2. Schedule the heartbeat, e.g.:
       crontab -e
       5 * * * * $DEST/heartbeat.sh
  3. Make sure the \`claude\` CLI is on PATH for whatever user/cron runs it.

Nothing has been scheduled yet — this only laid out the files.
EOF
