#!/bin/sh
# Install this Claude config into ~/.claude of the account Firetower runs agents as.
#
#   git clone <this repo> ~/claude-worker-config && ~/claude-worker-config/install.sh
#
# Re-run after a `git pull` to update. Files it replaces are backed up first.
#   --graphify   also install the graphify CLI (needs uv)
set -eu

HERE="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.claude"
GRAPHIFY=0
[ "${1:-}" = "--graphify" ] && GRAPHIFY=1

say() { printf '%s\n' "$*"; }

# ── 1. Files ─────────────────────────────────────────────────────────
mkdir -p "$DEST"
BACKUP="$DEST/backups/worker-config-$(date +%Y%m%d-%H%M%S)"
for f in CLAUDE.md RTK.md settings.json agents skills hooks; do
    if [ -e "$DEST/$f" ]; then
        mkdir -p "$BACKUP"
        cp -a "$DEST/$f" "$BACKUP/"
    fi
done
[ -d "$BACKUP" ] && say "backup: $BACKUP"

cp "$HERE/claude/CLAUDE.md" "$HERE/claude/RTK.md" "$HERE/claude/settings.json" "$DEST/"
for d in agents skills hooks; do
    mkdir -p "$DEST/$d"
    cp -r "$HERE/claude/$d/." "$DEST/$d/"
done
chmod +x "$DEST/hooks/"*
say "config: copied to $DEST"

# ── 2. Plugins ───────────────────────────────────────────────────────
# Firetower's own copy of claude is used when none is on PATH.
CLAUDE="$(command -v claude 2>/dev/null || true)"
if [ -z "$CLAUDE" ]; then
    CLAUDE="$(ls -d "$HOME"/.firetower/worker/agents/claude-code/*/bin/claude 2>/dev/null | sort -V | tail -1 || true)"
fi
if [ -n "$CLAUDE" ] && [ -x "$CLAUDE" ]; then
    for m in DietrichGebert/ponytail mattpocock/skills nextlevelbuilder/ui-ux-pro-max-skill; do
        "$CLAUDE" plugin marketplace add "$m" >/dev/null 2>&1 || true
    done
    "$CLAUDE" plugin marketplace update >/dev/null 2>&1 || true
    for p in ponytail@ponytail mattpocock-skills@mattpocock ui-ux-pro-max@ui-ux-pro-max-skill; do
        if "$CLAUDE" plugin install "$p" >/dev/null 2>&1; then say "plugin: $p"; else say "plugin: $p FAILED — run: $CLAUDE plugin install $p"; fi
    done
else
    say "plugins: skipped, no claude found — install the worker's Claude Code first, then re-run"
fi

# ── 3. rtk ───────────────────────────────────────────────────────────
if command -v rtk >/dev/null 2>&1 || [ -x "$HOME/.local/bin/rtk" ]; then
    say "rtk: already installed"
elif [ "$(uname -s)-$(uname -m)" = "Linux-x86_64" ]; then
    TMP="$(mktemp -d)"
    TAR="rtk-x86_64-unknown-linux-musl.tar.gz"
    URL="https://github.com/rtk-ai/rtk/releases/latest/download"
    curl -fsSL -o "$TMP/$TAR" "$URL/$TAR"
    curl -fsSL -o "$TMP/checksums.txt" "$URL/checksums.txt"
    (cd "$TMP" && grep " $TAR\$" checksums.txt | sha256sum -c - >/dev/null) || { say "rtk: checksum mismatch, not installed"; exit 1; }
    tar -xzf "$TMP/$TAR" -C "$TMP"
    mkdir -p "$HOME/.local/bin"
    install -m 755 "$(find "$TMP" -type f -name rtk | head -1)" "$HOME/.local/bin/rtk"
    rm -rf "$TMP"
    say "rtk: installed in ~/.local/bin"
else
    say "rtk: skipped, no prebuilt binary for $(uname -s)-$(uname -m)"
fi

# ── 4. graphify (optional) ───────────────────────────────────────────
if [ "$GRAPHIFY" -eq 1 ]; then
    if command -v uv >/dev/null 2>&1; then
        uv tool install --upgrade graphifyy -q && say "graphify: installed"
    else
        say "graphify: skipped, uv missing — curl -LsSf https://astral.sh/uv/install.sh | sh"
    fi
fi

say "done. Check with: $HOME/.firetower/worker/bin/firetower-worker doctor --agent claude-code"
