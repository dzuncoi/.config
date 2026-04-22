# macOS Setup Automation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Turn `~/.config` into a one-command Mac setup — clone the repo, run `./install.sh`, done.

**Architecture:** `install.sh` is the single entry point that delegates to four focused scripts in `scripts/`. Each script is idempotent and can be re-run independently. A curated `Brewfile` handles all package installation. macOS settings are applied via `defaults write`.

**Tech Stack:** bash, Homebrew (`brew bundle`), macOS `defaults` CLI

---

## File Map

| Action | Path | Responsibility |
|---|---|---|
| Create | `Brewfile` | Curated package list (20 packages) |
| Create | `scripts/brew.sh` | Install Homebrew + run `brew bundle` |
| Create | `scripts/symlinks.sh` | Create 3 symlinks |
| Create | `scripts/macos.sh` | Apply 5 `defaults write` settings |
| Create | `scripts/remind.sh` | Print manual checklist |
| Modify | `install.sh` | Orchestrate all 4 scripts |
| Modify | `git/config` | Add git user config (replaces `~/.gitconfig`) |

---

### Task 1: Create Brewfile

**Files:**
- Create: `Brewfile`

- [ ] **Step 1: Create the Brewfile**

```
tap "felixkratz/formulae"
tap "go-task/tap"
tap "hashicorp/tap"
tap "nikitabobko/tap"
tap "proxysoul/tap"

brew "direnv"
brew "gh"
brew "mise"
brew "neovim"
brew "nvm"
brew "pnpm"
brew "rbenv"
brew "ripgrep"
brew "starship"
brew "terminal-notifier"
brew "xcodegen"
brew "felixkratz/formulae/borders"
brew "felixkratz/formulae/sketchybar"
brew "go-task/tap/go-task"
brew "hashicorp/tap/vault"
brew "proxysoul/tap/soulforge"

cask "nikitabobko/tap/aerospace"
cask "font-hack-nerd-font"
cask "sf-symbols"
cask "wezterm"
```

- [ ] **Step 2: Verify Brewfile syntax**

```bash
brew bundle check --file=Brewfile
```

Expected: `The Brewfile's dependencies are satisfied.` (all already installed on current machine)

- [ ] **Step 3: Commit**

```bash
git add Brewfile
git commit -m "chore: add curated Brewfile"
```

---

### Task 2: Create scripts/brew.sh

**Files:**
- Create: `scripts/brew.sh`

- [ ] **Step 1: Create the scripts directory and brew.sh**

```bash
#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Checking Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "==> Installing packages from Brewfile..."
brew bundle install --file="$DOTFILES/Brewfile"

echo "==> Homebrew setup complete."
```

- [ ] **Step 2: Make it executable**

```bash
chmod +x scripts/brew.sh
```

- [ ] **Step 3: Syntax check**

```bash
bash -n scripts/brew.sh
```

Expected: no output (no errors)

- [ ] **Step 4: Commit**

```bash
git add scripts/brew.sh
git commit -m "chore: add brew.sh — installs Homebrew and packages"
```

---

### Task 3: Create scripts/symlinks.sh

**Files:**
- Create: `scripts/symlinks.sh`

- [ ] **Step 1: Create symlinks.sh**

```bash
#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Creating symlinks..."

# Claude Code (~/.claude is not XDG-compliant)
ln -sf "$DOTFILES/claude" "$HOME/.claude"
echo "  ~/.claude -> $DOTFILES/claude"

# Zsh (sets ZDOTDIR so zsh reads config from ~/.config/zsh/)
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv"
echo "  ~/.zshenv -> $DOTFILES/zsh/.zshenv"

# WezTerm (reads ~/.wezterm.lua by default)
ln -sf "$DOTFILES/wezterm/wezterm.lua" "$HOME/.wezterm.lua"
echo "  ~/.wezterm.lua -> $DOTFILES/wezterm/wezterm.lua"

echo "==> Symlinks complete."
```

- [ ] **Step 2: Make it executable**

```bash
chmod +x scripts/symlinks.sh
```

- [ ] **Step 3: Syntax check**

```bash
bash -n scripts/symlinks.sh
```

Expected: no output

- [ ] **Step 4: Run it on current machine to verify**

```bash
./scripts/symlinks.sh
```

Expected output:
```
==> Creating symlinks...
  ~/.claude -> /Users/<you>/.config/claude
  ~/.zshenv -> /Users/<you>/.config/zsh/.zshenv
  ~/.wezterm.lua -> /Users/<you>/.config/wezterm/wezterm.lua
==> Symlinks complete.
```

Verify: `ls -la ~/.claude ~/.zshenv ~/.wezterm.lua` — all should show `->` arrows.

- [ ] **Step 5: Commit**

```bash
git add scripts/symlinks.sh
git commit -m "chore: add symlinks.sh — creates all required symlinks"
```

---

### Task 4: Create scripts/macos.sh

**Files:**
- Create: `scripts/macos.sh`

- [ ] **Step 1: Create macos.sh**

```bash
#!/bin/bash
set -e

echo "==> Applying macOS settings..."

# Trackpad: enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Trackpad: enable three-finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Trackpad: set speed (0.875 = slightly below max)
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 0.875

# Dock: set icon size to 16px
defaults write com.apple.dock tilesize -int 16

# Finder: use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo "==> Restarting Dock and Finder..."
killall Dock Finder

echo "==> macOS settings applied."
```

- [ ] **Step 2: Make it executable**

```bash
chmod +x scripts/macos.sh
```

- [ ] **Step 3: Syntax check**

```bash
bash -n scripts/macos.sh
```

Expected: no output

- [ ] **Step 4: Run it on current machine to verify (safe — sets values already active)**

```bash
./scripts/macos.sh
```

Expected: Dock and Finder restart briefly, then come back. Settings unchanged (already matching).

- [ ] **Step 5: Commit**

```bash
git add scripts/macos.sh
git commit -m "chore: add macos.sh — applies essential system settings"
```

---

### Task 5: Create scripts/remind.sh

**Files:**
- Create: `scripts/remind.sh`

- [ ] **Step 1: Create remind.sh**

```bash
#!/bin/bash

echo ""
echo "============================================"
echo "  Setup complete! Manual steps remaining:"
echo "============================================"
echo ""
echo "[ ] SSH key:"
echo "      ssh-keygen -t ed25519 -C \"your@email.com\""
echo "      cat ~/.ssh/id_ed25519.pub  # add to GitHub"
echo ""
echo "[ ] Git credentials:"
echo "      Edit ~/.config/git/config with your name and email"
echo ""
echo "[ ] Sign in:"
echo "      App Store, iCloud"
echo ""
echo "[ ] Install Xcode from App Store (if iOS/macOS dev needed)"
echo ""
echo "[ ] Activate licenses for paid apps (e.g. Raycast Pro)"
echo ""
echo "[ ] Reboot to apply all settings cleanly"
echo ""
```

- [ ] **Step 2: Make it executable**

```bash
chmod +x scripts/remind.sh
```

- [ ] **Step 3: Syntax check and run**

```bash
bash -n scripts/remind.sh && ./scripts/remind.sh
```

Expected: checklist printed cleanly to terminal, no errors.

- [ ] **Step 4: Commit**

```bash
git add scripts/remind.sh
git commit -m "chore: add remind.sh — prints post-install manual steps"
```

---

### Task 6: Migrate git config

**Files:**
- Modify: `git/config` (create this file — git reads it natively at `~/.config/git/config`)

- [ ] **Step 1: Create git/config with user settings**

The current `~/.gitconfig` has:
```ini
[user]
    name = dzuncoi
    email = clock.quangdung@gmail.com
[core]
    excludesFile = /Users/dung.huynh/.config/git/ignore
```

Create `~/.config/git/config` with the hardcoded path fixed to use `~`:

```ini
[user]
    name = dzuncoi
    email = clock.quangdung@gmail.com
[core]
    excludesFile = ~/.config/git/ignore
```

- [ ] **Step 2: Verify git picks it up**

```bash
git config --global user.name
git config --global user.email
git config --global core.excludesFile
```

Expected:
```
dzuncoi
clock.quangdung@gmail.com
~/.config/git/ignore
```

- [ ] **Step 3: Remove the old ~/.gitconfig (now redundant)**

```bash
rm ~/.gitconfig
```

Then re-run step 2 to confirm git still reads config from `~/.config/git/config`.

- [ ] **Step 4: Commit**

```bash
git add git/config
git commit -m "chore: migrate gitconfig to XDG path ~/.config/git/config"
```

---

### Task 7: Rewrite install.sh

**Files:**
- Modify: `install.sh`

- [ ] **Step 1: Replace install.sh content**

```bash
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
```

- [ ] **Step 2: Syntax check**

```bash
bash -n install.sh
```

Expected: no output

- [ ] **Step 3: Dry-run verify all scripts are found and executable**

```bash
ls -la scripts/brew.sh scripts/symlinks.sh scripts/macos.sh scripts/remind.sh
```

Expected: all four files listed with `-rwxr-xr-x` permissions.

- [ ] **Step 4: Commit**

```bash
git add install.sh
git commit -m "chore: rewrite install.sh to orchestrate all setup scripts"
```

---

### Task 8: Final end-to-end verification

- [ ] **Step 1: Verify Brewfile is valid**

```bash
brew bundle check --file=Brewfile
```

Expected: `The Brewfile's dependencies are satisfied.`

- [ ] **Step 2: Run the full install script**

```bash
./install.sh
```

Expected: all four sections run cleanly, checklist printed at end, no errors.

- [ ] **Step 3: Verify symlinks**

```bash
ls -la ~/.claude ~/.zshenv ~/.wezterm.lua
```

Expected: all three are symlinks pointing into `~/.config/`.

- [ ] **Step 4: Verify git config**

```bash
git config --global user.name
git config --global core.excludesFile
```

Expected: `dzuncoi` and `~/.config/git/ignore`

- [ ] **Step 5: Update README with new setup instructions**

In `README.md`, update the Setup section to reflect the full install script behaviour:

```markdown
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
```

- [ ] **Step 6: Commit**

```bash
git add README.md
git commit -m "docs: update README with full setup instructions"
```
