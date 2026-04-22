#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "=============================="
echo "  macOS Setup"
echo "=============================="
echo ""

bash "$DOTFILES/scripts/brew.sh"
echo ""

bash "$DOTFILES/scripts/symlinks.sh"
echo ""

bash "$DOTFILES/scripts/macos.sh"
echo ""

bash "$DOTFILES/scripts/remind.sh"
