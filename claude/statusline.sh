#!/bin/bash

# ANSI escape codes using $'...' syntax so actual bytes are stored in variables
DIM=$'\033[2m'
RESET=$'\033[0m'
RED=$'\033[31m'
YELLOW=$'\033[33m'
GREEN=$'\033[32m'

# Read JSON input from stdin
input=$(cat)

# Extract each field individually to avoid word-splitting issues with spaces in values
cwd=$(echo "$input" | jq -r '.workspace.current_dir // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // ""')
vim_mode=$(echo "$input" | jq -r '.vim.mode // ""')

# Compute remaining from used percentage
remaining=""
if [ -n "$used" ]; then
  remaining=$(echo "scale=1; 100 - $used" | bc | sed 's/^\./0./')
fi

# Get short directory name (basename)
dir_name=$(basename "$cwd")

# Get git info using a single git status call
git_info=""
branch=""
status=""
git_status_output=$(git -C "$cwd" status --porcelain=v1 -b 2>/dev/null)
if [ $? -eq 0 ]; then
  # Parse branch from first line (## branch...tracking)
  branch=$(echo "$git_status_output" | head -1 | sed 's/^## //' | sed 's/\.\.\..*//' | sed 's/ .*//')
  [ -z "$branch" ] && branch="detached"

  # Check for any changes (lines after the first ## line)
  if echo "$git_status_output" | tail -n +2 | grep -q .; then
    status="*"
  fi

  git_info=" ${DIM}($branch$status)${RESET}"
fi

# Shorten model name for compactness
model_short=$(echo "$model" | sed 's/Claude //' | sed 's/3.5 //' | sed 's/Sonnet/S/' | sed 's/Opus/O/' | sed 's/Haiku/H/')

# Build context info
context_info=""
if [ -n "$remaining" ]; then
  # Color code context percentage
  if (( $(echo "$remaining < 20" | bc -l) )); then
    context_color="$RED"
  elif (( $(echo "$remaining < 50" | bc -l) )); then
    context_color="$YELLOW"
  else
    context_color="$GREEN"
  fi
  context_info=" ${DIM}•${RESET} ${context_color}${remaining}%${RESET}"
fi

# Build vim mode indicator
vim_info=""
vim_info_plain=""
if [ -n "$vim_mode" ]; then
  vim_mode_char=$(printf "\\$(printf '%03o' "$vim_mode")")
  case "$vim_mode_char" in
    N) vim_mode_label="NORMAL" ;;
    I) vim_mode_label="INSERT" ;;
    V) vim_mode_label="VISUAL" ;;
    R) vim_mode_label="REPLACE" ;;
    *) vim_mode_label="$vim_mode_char" ;;
  esac
  vim_info=" ${DIM}•${RESET} ${DIM}[${vim_mode_label}]${RESET}"
  vim_info_plain=" • [$vim_mode_label]"
fi

# Build plain text versions for terminal title (no color codes)
git_info_plain=""
if [ -n "$branch" ]; then
  git_info_plain=" ($branch$status)"
fi

context_info_plain=""
if [ -n "$remaining" ]; then
  context_info_plain=" • ${remaining}%"
fi

# Set terminal title using escape sequence (output to stderr to not interfere with status line)
terminal_title="${dir_name}${git_info_plain} • ${model_short}${context_info_plain}${vim_info_plain}"
printf '\033]0;%s\007' "$terminal_title" >&2

# Output the status line (to stdout)
printf "%s\n" "${DIM}${dir_name}${git_info}${RESET} ${DIM}•${RESET} ${model_short}${context_info}${vim_info}"
