#!/bin/bash
set -e

DOTFILES="$HOME/.config"

echo "Setting up symlinks..."

# Claude Code (~/.claude is not XDG, needs a symlink)
ln -sf "$DOTFILES/claude" "$HOME/.claude"

# Zsh (~/.zshenv sets ZDOTDIR so zsh reads all config from ~/.config/zsh/)
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv"

echo "Done."
