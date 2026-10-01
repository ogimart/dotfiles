#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.." || exit 1

mkdir -p "$HOME/.config"

CONFIG_LIST=(
  zsh
  vim
  tmux
  bat
  eza
  lazygit
  themes
  ghostty
)

stow \
  --target="$HOME" \
  --restow \
  "${CONFIG_LISTS[@]}"

