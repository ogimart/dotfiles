#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.." || exit 1

mkdir -p "$HOME/.config"

CONFIG_LIST=(
  shell
  readline
  vim
  tmux
  bat
  eza
  lazygit
  themes
  ghostty
)

case "$(uname -s)" in
  Linux)
    mkdir -p "$HOME/.backup"
    [ -f "$HOME/.bashrc" ] && mv "$HOME/.bashrc" "$HOME/.backup/.bashrc"
    [ -f "$HOME/.profile" ] && mv "$HOME/.profile" "$HOME/.backup/.profile"
    CONFIG_LIST+=(bash)
    ;;
  Darwin)
    CONFIG_LIST+=(zsh)
    ;;
esac

stow \
  --target="$HOME" \
  --restow \
  "${CONFIG_LISTS[@]}"

