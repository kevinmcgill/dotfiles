#!/bin/bash
#
# theme-switch.sh — called by dark-notify with "dark" or "light" as $1
#
# This script is the single entry point for tools that cannot detect
# macOS appearance changes on their own. Currently handles:
#   - tmux: sources the matching theme-{dark,light}.conf
#   - Claude Code: updates ~/.claude.json theme (not reliably picked up live)
#   - lazygit: swaps the theme.yml symlink (lazygit merges base + theme via
#     LG_CONFIG_FILE at startup — no generated file)
#
# opencode: uses "system" theme — auto-switches with macOS appearance natively.
#
# Neovim handles appearance changes natively via mode 2031
# (forwarded by tmux 3.6+, supported by Neovim 0.12+).

MODE="$1"

if [ "$MODE" != "dark" ] && [ "$MODE" != "light" ]; then
  echo "Usage: theme-switch.sh <dark|light>" >&2
  exit 1
fi

# --- tmux ---
# Use full path — launchd runs with a minimal PATH that excludes /opt/homebrew/bin
TMUX_BIN="/opt/homebrew/bin/tmux"
if "$TMUX_BIN" list-sessions &>/dev/null; then
  "$TMUX_BIN" source-file "$HOME/.config/tmux/theme-${MODE}.conf"
fi

# --- Claude Code ---
# Updates ~/.claude.json theme. Claude Code picks up the change immediately.
CLAUDE_THEME="${MODE}-daltonized"
CLAUDE_JSON="$HOME/.claude.json"
if [ -f "$CLAUDE_JSON" ]; then
  /opt/homebrew/bin/jq --arg theme "$CLAUDE_THEME" '.theme = $theme' "$CLAUDE_JSON" > /tmp/claude.json \
    && mv /tmp/claude.json "$CLAUDE_JSON"
fi

# --- lazygit ---
# Lazygit accepts multiple config files via LG_CONFIG_FILE (set in zshrc),
# merging them in order with later values overriding earlier. We point it
# at config.base.yml + theme.yml and just swap theme.yml's symlink target
# here. No generated file means no artifact to commit, no drift, and a
# single source of truth for both modes (edits to config.base.yml or the
# theme files are picked up on the next lazygit launch automatically).
#
# Relative symlink so it resolves correctly through the ~/.config/lazygit
# → dotfiles/lazygit dotbot symlink. -n prevents following an existing
# theme.yml symlink and creating the new link inside its target dir.
ln -sfn "theme-${MODE}.yml" "$HOME/.config/lazygit/theme.yml"
