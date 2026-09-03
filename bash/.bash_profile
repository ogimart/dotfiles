# ~/.bash_profile

################################################################################
# OPERATING SYSTEM
OS="$(uname -s)"

################################################################################
# XDG
export XDG_CONFIG_HOME="$HOME/.config"

################################################################################
# HOMEBREW
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "$HOME/.linuxbrew/bin/brew" ]; then
  eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [ -n "$HOMEBREW_PREFIX" ]; then
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_INSECURE_REDIRECT=1
  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_NO_EMOJI=1
fi

################################################################################
# RUST
[ -r "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

################################################################################
# CMAKE
export CMAKE_EXPORT_COMPILE_COMMANDS=1
export CMAKE_GENERATOR=Ninja

################################################################################
# JAVA
export JAVA_HOME=/opt/jvm/jdk-zulu-21
export PATH="$JAVA_HOME/bin:$PATH"

export GRADLE_HOME=/opt/jvm/gradle-9.1.0
export PATH="$GRADLE_HOME/bin:$PATH"

################################################################################
# OPENCODE
# TODO

################################################################################
# POSTGRESQL
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

################################################################################
# LATEX
# TODO

################################################################################
# FZF
if command -v fzf >/dev/null 2>&1; then
  if command -v rg >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!{.git,node_modules,vendor,target,build,out}/*"'
  fi

  # Catppuccin Mocha
  export FZF_DEFAULT_OPTS=" \
  --color=fg:#ced5f1,bg:#1e1d2c,hl:#91b2f4 \
  --color=fg+:#ced5f1,bg+:#1e1d2c,hl+:#a5dfd5 \
  --color=info:#ced5f1,prompt:#e490a7,pointer:#a5dfd5 \
  --color=marker:#91b2f4,spinner:#ced5f1,header:#ced5f1 \
  --multi"
fi

################################################################################
# USER BIN
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

################################################################################
# LIMA VM
if [[ "$OS" == "Darwin" ]]; then
  export LIMA_INSTANCE=default
fi
if [[ "$OS" == "Linux" ]]; then
  export PATH="$PATH:/usr/sbin:/sbin"
fi

################################################################################
# BASHRC
[ -r ~/.bashrc ] && . "$HOME/.bashrc"

################################################################################
# SECRETS
[ -r ~/.secrets ] && . "$HOME/.secrets"

################################################################################
