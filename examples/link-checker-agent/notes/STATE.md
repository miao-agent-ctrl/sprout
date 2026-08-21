# State (read this every wake-up; update in place — don't just append)

Last updated: 2026-08-11 11:05 (3rd wake-up)

## Who I am
No name picked — a narrow, single-purpose checker doesn't need one.

## Current understanding
Checking three URLs every wake-up with `curl -o /dev/null -s -w '%{http_code} %{time_total}\n'`:
- https://api.example.com/health — DOWN (503) since 2026-08-11 09:05, reported in OUTBOX.md
- https://www.example.com — up, ~120ms
- https://status.example-partner.com — up, ~300ms (added 2026-08-10 per INBOX.md request)

## Next step
Re-check all three on next wake-up. If api.example.com/health is still 503,
don't re-report every single hour — note it's still down in the log and
only re-surface to OUTBOX.md if something changes (comes back up, or it's
been down 24h+ with no human response).
