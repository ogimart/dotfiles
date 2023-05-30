# .bashrc
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# GO
export PATH="$PATH:$(go env GOPATH)/bin"
export GOPATH="$(go env GOPATH)"

# RUST
source "$HOME/.cargo/env"
