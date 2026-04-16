#!/bin/bash
set -e

DOTFILES="$HOME/.config"

echo "Setting up symlinks..."

# Claude Code (~/.claude is not XDG, needs a symlink)
ln -sf "$DOTFILES/claude" "$HOME/.claude"

echo "Done."
