# dotfiles

Personal macOS development environment configuration.

## Overview

Keyboard-driven workflow built around Neovim, a tiling window manager, and a custom status bar.

## Contents

### Shell
- **[fish](./fish/)** — Fish shell configuration
- **[zsh](./zsh/)** — Zsh configuration
- **[starship](./starship.toml)** — Cross-shell prompt

### Editor
- **[nvim](./nvim/)** — Neovim config based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with [lazy.nvim](https://github.com/folke/lazy.nvim). Plugins include LSP, Telescope, Copilot, Lualine, nvim-tree, and more.
- **[zed](./zed/)** — Zed editor config

### Terminal
- **[ghostty](./ghostty/)** — Primary terminal (NvimDark theme)
- **[wezterm](./wezterm/)** — WezTerm with custom tab bar and FiraCode Nerd Font
- **[alacritty](./alacritty/)** — Alacritty terminal

### Window Management & UI
- **[aerospace](./aerospace/)** — AeroSpace tiling window manager
- **[sketchybar](./sketchybar/)** — Custom macOS menu bar with: Apple menu, Spaces, front app, Spotify, calendar, Brew updates, GitHub notifications, battery, volume, CPU
- **[borders](./borders/)** — JankyBorders with rounded gradient borders (active: yellow→purple, inactive: teal→purple)

### Tools
- **[git](./git/)** — Git configuration
- **[gh](./gh/)** — GitHub CLI
- **[raycast](./raycast/)** — Raycast launcher
- **[claude](./claude/)** — Claude Code global config (CLAUDE.md, settings, agents, rules, skills)

## Setup

Clone to `~/.config` and run the install script:

```sh
git clone <repo-url> ~/.config
cd ~/.config
./install.sh
```

`install.sh` runs four steps automatically:
1. **Homebrew** — installs Homebrew if absent, then runs `brew bundle install`
2. **Symlinks** — creates `~/.claude`, `~/.zshenv`, `~/.wezterm.lua`
3. **macOS settings** — applies trackpad, Dock, and Finder preferences
4. **Checklist** — prints manual steps (SSH key, git credentials, App Store sign-in)

Each `scripts/*.sh` can also be run independently.

### Dependencies

- [Neovim](https://neovim.io/) v0.11.4
- [AeroSpace](https://github.com/nikitabobko/AeroSpace)
- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- [JankyBorders](https://github.com/FelixKratz/JankyBorders)
- [Ghostty](https://ghostty.org/)
- [Fish shell](https://fishshell.com/)
- [Starship](https://starship.rs/)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (required by Neovim Telescope)
- SF Pro font (for SketchyBar)
- FiraCode Nerd Font (for terminals)
