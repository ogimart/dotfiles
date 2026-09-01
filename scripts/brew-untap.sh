#!/bin/bash

ALLOWED_TAPS=("homebrew/core" "homebrew/cask")
CURRENT_TAPS=$(brew tap)

for TAP in $CURRENT_TAPS; do
  if [[ ! " ${ALLOWED_TAPS[*]} " =~ " ${TAP} " ]]; then
    echo "Untapping unauthorized tap: $TAP"
    brew untap "$TAP"
  fi
done

echo "Only authorized taps remain."

