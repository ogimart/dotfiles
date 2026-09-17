#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.." || exit 1

PACKAGES=(
  fish
  bash
  nvim
  tmux
  bat
  eza
  lazygit
  themes
  ghostty
)

mkdir -p "$HOME/.config"

# fish
rm -f "$HOME/.config/fish/config.fish"
rm -f "$HOME/.config/fish/functions/fish_prompt.fish"

stow \
  --target="$HOME" \
  --restow \
  "${PACKAGES[@]}"
