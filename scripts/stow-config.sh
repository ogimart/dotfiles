#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.." || exit 1

PACKAGES=(
  bash
  nvim
  tmux
  bat
  lazygit
  themes
  ghostty
)

mkdir -p "$HOME/.config"

stow \
  --target="$HOME" \
  --restow \
  "${PACKAGES[@]}"
