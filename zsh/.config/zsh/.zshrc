# ~/.zshrc

################################################################################
# OPERATING SYSTEM
OS="$(uname -s)"

################################################################################
# NON-INTERACTIVE CHECK
[[ -o interactive ]] || return

################################################################################
# TERMINAL
export EDITOR=vi
export VISUAL=vi
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

bindkey -e

################################################################################
# HISTORY
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory
setopt sharehistory
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space

################################################################################
# COMPLETION & ZSH ENHANCEMENTS
if [[ "$OS" == "Darwin" ]] && type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' group-name ''

setopt autocd
setopt correct
setopt PROMPT_SUBST

################################################################################
# PROMPT & GIT (vcs_info)
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' (%b)'
zstyle ':vcs_info:git:*' actionformats ' (%b|%a)'

__venv_info() {
  [ -n "$VIRTUAL_ENV" ] && printf "(%s) " "$(basename "$VIRTUAL_ENV")"
}

precmd() {
  vcs_info

  local venv width threshold
  venv="$(__venv_info)"
  local git="${vcs_info_msg_0_}"

  # Use ${PWD:t} to get the folder name and measure its length correctly
  width=$(( ${#venv} + ${#USER} + ${#HOST} + ${#${PWD:t}} + ${#git} + 2 ))
  threshold=$(( COLUMNS * 75 / 100 ))

  PROMPT="%F{magenta}${venv}%f%F{cyan}%n@%m%f:%F{blue}%1c%f%F{yellow}${git}%f"
  if (( width > threshold )); then
    PROMPT+=$'\n%% '
  else
    PROMPT+=' %% '
  fi
}

################################################################################
# FZF
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

################################################################################
# POSTGRESQL
if command -v psql >/dev/null 2>&1; then
  psql() {
    command psql -h localhost -p 5432 -U postgres -d postgres "$@"
  }
fi

################################################################################
# ALIASES
export EZA_CONFIG_DIR="$HOME/.config/eza"
alias ls="eza --group-directories-first"
alias la="eza -a --group-directories-first"
alias ll="eza -al --time-style=long-iso --group-directories-first"
alias lla="eza -alhmU --group --time-style=long-iso --group-directories-first"
alias tree="eza --tree --group-directories-first -I .git"
alias tm="tmux new -s main"
alias em="emacs -nw"
alias ee="emacs -nw -Q -l ~/.config/emacs/quick-init.el"
alias vi="nvim"
alias cat="bat -pp"
alias lg="lazygit"
alias pathlist='echo "$PATH" | tr ":" "\n"'
alias scheme="chez --libdirs ."

# os specific
if [[ "$OS" == "Darwin" ]]; then
  alias awslocal='aws --profile localstack'
  alias docker='lima nerdctl'
  alias lmake="lima make"
  alias lcmake="lima cmake"
  alias lctest="lima ctest"
  alias lnpsql='lima nerdctl exec -it timescaledb psql -U postgres'
  alias ew="open -a Emacs"
elif [[ "$OS" == "Linux" ]]; then
  alias grep='grep --color=auto'
  alias docker='nerdctl'
fi

# ~/.zshrc - eof
