#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Creating symlinks..."

# Claude Code (~/.claude is not XDG-compliant)
ln -sfh "$DOTFILES/claude" "$HOME/.claude"
echo "  ~/.claude -> $DOTFILES/claude"

# Zsh (sets ZDOTDIR so zsh reads config from ~/.config/zsh/)
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv"
echo "  ~/.zshenv -> $DOTFILES/zsh/.zshenv"

# WezTerm (reads ~/.wezterm.lua by default)
ln -sf "$DOTFILES/wezterm/wezterm.lua" "$HOME/.wezterm.lua"
echo "  ~/.wezterm.lua -> $DOTFILES/wezterm/wezterm.lua"

echo "==> Symlinks complete."
