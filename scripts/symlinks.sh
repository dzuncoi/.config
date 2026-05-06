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

echo ""
echo "==> Verifying symlinks..."
FAILED=0
verify_symlink() {
  local link="$1"
  local target="$2"
  if [ -L "$link" ] && [ "$(readlink "$link")" = "$target" ]; then
    echo "  [ok] $link -> $target"
  else
    echo "  [FAIL] $link is not linked to $target"
    FAILED=1
  fi
}

verify_symlink "$HOME/.claude" "$DOTFILES/claude"
verify_symlink "$HOME/.zshenv" "$DOTFILES/zsh/.zshenv"
verify_symlink "$HOME/.wezterm.lua" "$DOTFILES/wezterm/wezterm.lua"

if [ $FAILED -ne 0 ]; then
  echo ""
  echo "ERROR: One or more symlinks failed. Check the output above."
  exit 1
fi
