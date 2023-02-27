# .zprofile
#
# This is a generated file from ~/.dotfiles/zsh.org
# Do not edit!

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$PATH:$(go env GOPATH)/bin"
export GOPATH="$(go env GOPATH)"

source "$HOME/.cargo/env"
