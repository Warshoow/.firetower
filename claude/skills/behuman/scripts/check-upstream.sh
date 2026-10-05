#!/usr/bin/env bash
# Compare this skill against blader/humanizer upstream.
#
# Default run is read-only: it fetches the upstream SKILL.md, compares its
# version and pattern count against the values pinned in UPSTREAM.md, and
# reports the drift. It never edits the catalog, because deciding where a
# new pattern belongs needs judgement.
#
# Usage:
#   bash scripts/check-upstream.sh            report drift, list new pattern titles
#   bash scripts/check-upstream.sh --show     also print the full text of new patterns
#   bash scripts/check-upstream.sh --pin      rewrite the pin in UPSTREAM.md (see warning)
#
# Exit codes: 0 up to date, 1 drift detected, 2 could not check.

set -uo pipefail

MODE="report"
case "${1:-}" in
  --show) MODE="show" ;;
  --pin)  MODE="pin" ;;
  "")     ;;
  *) echo "unknown option: $1 (use --show or --pin)" >&2; exit 2 ;;
esac

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PIN_FILE="$SKILL_DIR/UPSTREAM.md"
RAW_URL="https://raw.githubusercontent.com/blader/humanizer/main/SKILL.md"

[ -f "$PIN_FILE" ] || { echo "error: UPSTREAM.md not found." >&2; exit 2; }

read_pin() { grep -m1 "^$1=" "$PIN_FILE" | cut -d= -f2- | tr -d '[:space:]'; }

PINNED_VERSION="$(read_pin UPSTREAM_PINNED_VERSION)"
PINNED_COUNT="$(read_pin UPSTREAM_PINNED_PATTERN_COUNT)"
MERGED_ON="$(read_pin MERGED_ON)"

[ -n "$PINNED_VERSION" ] || { echo "error: UPSTREAM_PINNED_VERSION missing." >&2; exit 2; }

TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

if ! curl -sSfL --max-time 20 "$RAW_URL" -o "$TMP"; then
  echo "Could not reach raw.githubusercontent.com."
  echo "If this environment restricts network access, check by hand:"
  echo "  https://github.com/blader/humanizer/blob/main/SKILL.md"
  exit 2
fi

REMOTE_VERSION="$(grep -m1 -E '^[[:space:]]*version:' "$TMP" \
  | sed -E 's/.*version:[[:space:]]*"?([^"[:space:]]+)"?.*/\1/')"
REMOTE_COUNT="$(grep -c -E '^### [0-9]+\.' "$TMP")"

if [ -z "$REMOTE_VERSION" ]; then
  echo "Fetched the file but could not read its version."
  echo "The frontmatter format probably changed. Inspect it by hand."
  exit 2
fi

echo "blader/humanizer"
echo "  pinned here : $PINNED_VERSION  ($PINNED_COUNT patterns, merged $MERGED_ON)"
echo "  upstream now: $REMOTE_VERSION  ($REMOTE_COUNT patterns)"
echo

if [ "$MODE" = "pin" ]; then
  if [ "$REMOTE_VERSION" = "$PINNED_VERSION" ]; then
    echo "Already pinned to $REMOTE_VERSION. Nothing to write."
    exit 0
  fi
  echo "This only moves the pin. It does NOT merge anything."
  echo "Run it after the catalog has actually been updated, never before,"
  echo "or the skill will claim to cover patterns it does not have."
  echo
  read -r -p "Move pin to $REMOTE_VERSION / $REMOTE_COUNT patterns? [y/N] " ok
  case "$ok" in
    y|Y|yes|YES)
      sed -i.bak \
        -e "s/^UPSTREAM_PINNED_VERSION=.*/UPSTREAM_PINNED_VERSION=$REMOTE_VERSION/" \
        -e "s/^UPSTREAM_PINNED_PATTERN_COUNT=.*/UPSTREAM_PINNED_PATTERN_COUNT=$REMOTE_COUNT/" \
        -e "s/^MERGED_ON=.*/MERGED_ON=$(date +%F)/" \
        "$PIN_FILE"
      rm -f "$PIN_FILE.bak"
      echo "Pin updated. Now bump metadata.version in SKILL.md by hand."
      exit 0 ;;
    *) echo "Aborted. Nothing written."; exit 1 ;;
  esac
fi

if [ "$REMOTE_VERSION" = "$PINNED_VERSION" ]; then
  echo "Up to date. Nothing to do."
  exit 0
fi

echo "Upstream has moved: $PINNED_VERSION -> $REMOTE_VERSION"

if [ "$REMOTE_COUNT" -gt "$PINNED_COUNT" ] 2>/dev/null; then
  echo
  echo "New numbered patterns since the merge:"
  awk -v pinned="$PINNED_COUNT" '
    /^### [0-9]+\./ { n = $2 + 0; if (n > pinned) { line = $0; sub(/^### /, "  ", line); print line } }
  ' "$TMP"

  if [ "$MODE" = "show" ]; then
    echo
    echo "----- full text of the new patterns -----"
    awk -v pinned="$PINNED_COUNT" '
      /^#{2,3} / { inblock = 0 }
      /^### [0-9]+\./ { n = $2 + 0; inblock = (n > pinned) }
      inblock { print }
    ' "$TMP"
    echo "----- end -----"
  else
    echo
    echo "Re-run with --show to print their full text."
  fi
elif [ "$REMOTE_COUNT" -lt "$PINNED_COUNT" ] 2>/dev/null; then
  echo
  echo "Upstream now has fewer numbered patterns than the pin."
  echo "Something was removed or renumbered. Diff by hand before merging."
else
  echo
  echo "Same pattern count, so this is a revision to existing patterns"
  echo "rather than a new one. Diff the wording before deciding to merge."
fi

echo
echo "To catch up, follow the steps in UPSTREAM.md, then run --pin."
echo "Release notes: https://github.com/blader/humanizer#version-history"
exit 1
