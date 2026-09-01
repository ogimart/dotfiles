#!/usr/bin/env bash

set -e
OS="$(uname -s)"

cd "$(dirname "$0")/.." || exit 1

################################################################################
# Dependencies
install_dependencies() {
  # Linux dependencies
  if [[ "$OS" == "Linux" ]]; then
    echo "Linux detected."

    sudo apt-get update -y
    sudo apt-get install -y build-essential procps curl file git valgrind

    # perf: linux-tools is kernel-specific and unavailable on some kernels
    # (containers, WSL), so failure here is not fatal.
    # sudo apt-get install -y linux-tools-common linux-tools-generic \
    #   "linux-tools-$(uname -r)" ||
    #   echo "Warning: could not install perf (linux-tools) for kernel $(uname -r)."
  fi

  # macOS dependencies
  if [[ "$OS" == "Darwin" ]]; then
    echo "macOS detected."

    # Command Line Tools for Xcode
    if ! xcode-select -p &>/dev/null; then
      echo "Installing Xcode Command Line Tools..."
      xcode-select --install

      echo "Waiting for installation to finish..."

      until xcode-select -p &>/dev/null; do
        sleep 5
      done

      echo "Xcode Command Line Tools installed."
    else
      echo "Xcode Command Line Tools already installed."
    fi
  fi
}

################################################################################
# Homebrew
install_homebrew() {
  if command -v brew &>/dev/null; then
    echo "Homebrew already installed."
    return
  fi

  echo "Installing Homebrew..."

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ "$OS" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ "$OS" == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi

  echo "Homebrew installed."
}

################################################################################
# Homebrew packages
install_packages() {
  echo "Installing Homebrew packages..."

  brew bundle install --file Brewfile

  echo "Homebrew packages installed."
}

# Rust
install_rust () {
  if command -v rustup &>/dev/null; then
    echo "Rust already installed."
    return
  fi

  echo "Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
  echo "Rust installed"
}

################################################################################
# Install
install_dependencies
install_homebrew
install_packages
install_rust

echo "Install complete."
