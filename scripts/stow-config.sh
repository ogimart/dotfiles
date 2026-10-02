#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.." || exit 1

mkdir -p "$HOME/.config"

CONFIG_LIST=(
  shell
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

    if [ -f "$HOME/.bashrc" ] && [ ! -e "$HOME/.backup/.bashrc" ]; then
      cp -p "$HOME/.bashrc" "$HOME/.backup/.bashrc"
    fi

    if [ -f "$HOME/.profile" ] && [ ! -e "$HOME/.backup/.profile" ]; then
      cp -p "$HOME/.profile" "$HOME/.backup/.profile"
    fi

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

