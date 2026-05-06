#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Activating mise..."
eval "$(mise activate bash)"

echo "==> Installing tools from mise/config.toml..."
mise install

echo "==> mise setup complete."
