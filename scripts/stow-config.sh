#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.." || exit 1

# Shell config in ~/
if [[ "$OS" == "Darwin" ]]; then
  stow --target="$HOME" --restow zsh
fi

if [[ "$OS" == "Linux" ]]; then
  stow --target="$HOME" --restow bash
fi

# Vim config in ~/
stow --target="$HOME" --restow vim

# Common Packages Config in ~/.config
mkdir -p "$HOME/.config"

PACKAGES=(
  nvim
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
  "${PACKAGES[@]}"

