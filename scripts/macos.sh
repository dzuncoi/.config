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
