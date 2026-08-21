#!/bin/bash
# test.sh: smoke tests for init.sh. Run from anywhere: ./test.sh
set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

PASS=0
FAIL=0

check() {
  local desc="$1"
  shift
  if "$@"; then
    echo "ok   - $desc"
    PASS=$((PASS + 1))
  else
    echo "FAIL - $desc"
    FAIL=$((FAIL + 1))
  fi
}

# 1. Normal copy: init.sh creates the destination populated from template/.
DEST="$WORKDIR/new-agent"
"$SCRIPT_DIR/init.sh" "$DEST" >/dev/null 2>&1
check "init.sh creates the destination directory" [ -d "$DEST" ]
check "GOAL.md was copied" [ -f "$DEST/GOAL.md" ]
check "heartbeat.sh was copied" [ -f "$DEST/heartbeat.sh" ]
check "heartbeat.sh is executable" [ -x "$DEST/heartbeat.sh" ]
check "notes/STATE.md was copied" [ -f "$DEST/notes/STATE.md" ]
check "notes/LOG.md was copied" [ -f "$DEST/notes/LOG.md" ]

# 2. Copied tree matches template/ content-for-content (minus permissions).
if diff -rq "$SCRIPT_DIR/template" "$DEST" >/dev/null 2>&1; then
  check "copied tree matches template/ exactly" true
else
  check "copied tree matches template/ exactly" false
fi

# 3. Refuses to overwrite an existing path.
if "$SCRIPT_DIR/init.sh" "$DEST" >/dev/null 2>&1; then
  check "init.sh refuses to overwrite an existing path" false
else
  check "init.sh refuses to overwrite an existing path" true
fi

# 4. Usage error when called with the wrong number of arguments.
if "$SCRIPT_DIR/init.sh" >/dev/null 2>&1; then
  check "init.sh rejects being called with no arguments" false
else
  check "init.sh rejects being called with no arguments" true
fi


# 5. examples/link-checker-agent matches what examples/README.md claims about it:
#    all the template's content files are present, WAKE.md is unmodified from
#    template/ (the example only fills in content, not the wake instructions),
#    and heartbeat.sh is deliberately absent since the example is for reading,
#    not running.
EXAMPLE="$SCRIPT_DIR/examples/link-checker-agent"
check "example has GOAL.md" [ -f "$EXAMPLE/GOAL.md" ]
check "example has INBOX.md" [ -f "$EXAMPLE/INBOX.md" ]
check "example has OUTBOX.md" [ -f "$EXAMPLE/OUTBOX.md" ]
check "example has notes/STATE.md" [ -f "$EXAMPLE/notes/STATE.md" ]
check "example has notes/LOG.md" [ -f "$EXAMPLE/notes/LOG.md" ]
if diff -q "$SCRIPT_DIR/template/WAKE.md" "$EXAMPLE/WAKE.md" >/dev/null 2>&1; then
  check "example WAKE.md matches template/WAKE.md" true
else
  check "example WAKE.md matches template/WAKE.md" false
fi
if [ -f "$EXAMPLE/heartbeat.sh" ]; then
  check "example has no heartbeat.sh (read-only, on purpose)" false
else
  check "example has no heartbeat.sh (read-only, on purpose)" true
fi

echo
echo "$PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
