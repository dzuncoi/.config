#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Activating mise..."
eval "$(mise activate bash)"

echo "==> Installing tools from .mise.toml..."
mise install -C "$DOTFILES"

echo "==> mise setup complete."
