#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "=============================="
echo "  macOS Setup"
echo "=============================="
echo ""
echo "WARNING: This script will:"
echo "  - Install/update Homebrew packages from Brewfile"
echo "  - Overwrite ~/.claude, ~/.zshenv, ~/.wezterm.lua with symlinks"
echo "  - Apply macOS defaults (trackpad, Dock, Finder)"
echo ""
echo "Existing files at those paths will be replaced without backup."
echo ""
read -r -p "Continue? [y/N] " reply
if [[ ! "$reply" =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 0
fi
echo ""

bash "$DOTFILES/scripts/brew.sh"
echo ""

bash "$DOTFILES/scripts/symlinks.sh"
echo ""

bash "$DOTFILES/scripts/macos.sh"
echo ""

bash "$DOTFILES/scripts/remind.sh"
