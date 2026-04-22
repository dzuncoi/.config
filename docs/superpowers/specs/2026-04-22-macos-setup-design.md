# macOS Setup Automation Design

**Date:** 2026-04-22  
**Goal:** Clone repo + run one script = fully configured Mac dev environment

---

## Overview

Expand `~/.config` (this repo) into a complete Mac setup system. A new device requires only:

```sh
git clone <repo-url> ~/.config
cd ~/.config
./install.sh
```

---

## File Structure

```
~/.config/
├── Brewfile                  # curated package list
├── install.sh                # entry point: calls all scripts in order
├── scripts/
│   ├── brew.sh               # install Homebrew if absent + brew bundle install
│   ├── symlinks.sh           # create all symlinks
│   ├── macos.sh              # defaults write for essential settings
│   └── remind.sh             # print manual checklist at end
└── docs/
    └── superpowers/specs/    # design docs
```

Each script is idempotent — safe to re-run independently.

---

## Brewfile

Curated list of 20 packages (16 formulae, 4 casks). Covers: CLI tools, window management, terminal, editor, fonts.

**Taps:** `felixkratz/formulae`, `go-task/tap`, `hashicorp/tap`, `nikitabobko/tap`, `proxysoul/tap`

**Formulae:**
- Shell/prompt: `starship`
- Editor: `neovim`
- Search: `ripgrep`
- Version control: `gh`
- Node: `nvm`, `pnpm`
- Runtime management: `mise`, `rbenv`
- Dev tools: `direnv`, `xcodegen`, `terminal-notifier`
- Secrets: `hashicorp/tap/vault`
- UI: `felixkratz/formulae/sketchybar`, `felixkratz/formulae/borders`
- Tasks: `go-task/tap/go-task`
- Internal: `proxysoul/tap/soulforge`

**Casks:** `nikitabobko/tap/aerospace`, `wezterm`, `font-hack-nerd-font`, `sf-symbols`

**Excluded (non-essential):** `neofetch`, `gojq`, `yt-dlp`, `ollama`

---

## Symlinks

`scripts/symlinks.sh` creates these on a new machine:

| Symlink | Target | Why |
|---|---|---|
| `~/.claude` | `~/.config/claude` | Claude Code not XDG-compliant |
| `~/.zshenv` | `~/.config/zsh/.zshenv` | Sets ZDOTDIR so zsh reads from `~/.config/zsh/` |
| `~/.wezterm.lua` | `~/.config/wezterm/wezterm.lua` | WezTerm reads `~/.wezterm.lua` by default |

**Git config migration:** `~/.gitconfig` moved to `~/.config/git/config` — git natively reads this XDG path, no symlink needed. Tracked in repo (contains name/email only, no secrets).

---

## macOS Settings

`scripts/macos.sh` applies only non-default values currently set on the machine:

| Domain | Key | Value | Effect |
|---|---|---|---|
| `com.apple.AppleMultitouchTrackpad` | `Clicking` | `1` | Tap to click |
| `com.apple.AppleMultitouchTrackpad` | `TrackpadThreeFingerDrag` | `1` | Three-finger drag |
| `NSGlobalDomain` | `com.apple.trackpad.scaling` | `0.875` | Trackpad speed |
| `com.apple.dock` | `tilesize` | `16` | Dock icon size |
| `com.apple.finder` | `FXPreferredViewStyle` | `Nlsv` | Finder list view |

Script ends with `killall Dock Finder` to apply changes immediately.

**Excluded:** keyboard repeat (left at macOS defaults), Dock autohide (left at macOS defaults).

---

## Manual Reminders

`scripts/remind.sh` prints a checklist of steps that cannot be scripted:

- Generate SSH key + add to GitHub
- Update `~/.config/git/config` with name/email
- Sign in to App Store and iCloud
- Install Xcode from App Store (if needed)
- Activate licenses for paid apps
- Reboot to apply all settings cleanly

---

## install.sh Flow

```
install.sh
  └─ scripts/brew.sh       # 1. packages
  └─ scripts/symlinks.sh   # 2. symlinks
  └─ scripts/macos.sh      # 3. system settings
  └─ scripts/remind.sh     # 4. print checklist
```

Exits immediately on any error (`set -e`).
