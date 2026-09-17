# ~/.config/fish/config.fish

set fish_greeting ""

################################################################################
# XDG
set -gx XDG_CONFIG_HOME "$HOME/.config"

################################################################################
# Terminal
set -gx EDITOR nvim
set -gx EZA_CONFIG_DIR "$HOME/.config/eza"

################################################################################
# HOMEBREW
if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
else if test -x /home/linuxbrew/.linuxbrew/bin/brew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
end

if test -n "$HOMEBREW_PREFIX"
    set -gx HOMEBREW_NO_ANALYTICS 1
    set -gx HOMEBREW_NO_INSECURE_REDIRECT 1
    set -gx HOMEBREW_NO_AUTO_UPDATE 1
    set -gx HOMEBREW_NO_EMOJI 1
end

################################################################################
# RUST
fish_add_path $HOME/.cargo/bin

################################################################################
# CMAKE
set -gx CMAKE_EXPORT_COMPILE_COMMANDS 1
set -gx CMAKE_GENERATOR Ninja

################################################################################
# PYTHON
set -gx VIRTUAL_ENV_DISABLE_PROMPT true

################################################################################
# JAVA
if test "$fish_os" = Darwin
  set -gx JAVA_HOME /opt/jvm/jdk-zulu-21
  set -gx GRADLE_HOME /opt/jvm/gradle-9.1.0
  fish_add_path "$JAVA_HOME/bin" "$GRADLE_HOME/bin"
end

################################################################################
# OPENCODE TODO
# fish_add_path "$HOME/.opencode/bin"

################################################################################
# POSTGRESQL
if test "$fish_os" = Darwin
  fish_add_path /opt/homebrew/opt/libpq/bin
end

################################################################################
# LATEX TODO
if test "$fish_os" = Darwin
end

# ################################################################################
# FZF
if  command -q fzf
  fzf --fish | source
  bind \er history-pager
end

set -gx FZF_CTRL_R_OPTS '--height=40% --layout=reverse --scheme=history'

if command -q rg
  set -gx FZF_DEFAULT_COMMAND \
    'rg --files --hidden --follow --glob "!{.git,node_modules,vendor,target,build,out}/*"'
end

# Catppuccin Mocha theme & default options
set -gx FZF_DEFAULT_OPTS " \
--color=fg:#ced5f1,bg:#1e1d2c,hl:#91b2f4 \
--color=fg+:#ced5f1,bg+:#1e1d2c,hl+:#a5dfd5 \
--color=info:#ced5f1,prompt:#e490a7,pointer:#a5dfd5 \
--color=marker:#91b2f4,spinner:#ced5f1,header:#ced5f1"

################################################################################
# LIMA VM
if test "$fish_os" = Darwin
    set -gx LIMA_INSTANCE default
end
if test "$fish_os" = Linux
    fish_add_path --append /usr/sbin /sbin
end

################################################################################
# USER BIN
fish_add_path ~/bin ~/.local/bin

################################################################################
# SECRETS
if test -r "$HOME/.secrets.fish"
    source "$HOME/.secrets.fish"
end

################################################################################
# INTERACTIVE 
if status is-interactive
  # Commands to run in interactive sessions can go here
  set -g fish_pager_color_progress gray

  # common aliases
  alias ls="eza --group-directories-first"
  alias la="eza -a --group-directories-first"
  alias ll="eza -al --time-style=long-iso --group-directories-first"
  alias lla="eza -alhmU --group --time-style=long-iso --group-directories-first"
  alias tree="eza --tree --group-directories-first -I .git"
  alias vi="nvim"
  alias lg="lazygit"
  alias pathlist="string join \n \$PATH"
  alias scheme="chez --libdirs ."

  # os specific
  if test "$fish_os" = Darwin
    # aws
    alias awslocal='aws --profile localstack'
    # lima aliases
    alias docker='lima nerdctl'
    alias lmake="lima make"
    alias lcmake="lima cmake"
    alias lctest="lima ctest"
    alias lnpsql='lima nerdctl exec -it timescaledb psql -U postgres'
  else if test "$fish_os" = Linux
    alias grep='grep --color=auto'
    alias docker='nerdctl'
  end
end
