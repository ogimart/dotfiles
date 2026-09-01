# ~/.bashrc

################################################################################
# OPERATING SYSTEM
OS="$(uname -s)"

################################################################################
# NON-INTERACTIVE
# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

################################################################################
# TERMINAL
export EDITOR=vi
export VISUAL=vi
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

################################################################################
# HISTORY
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

################################################################################
# COMPLETION
case "$OS" in
  Darwin)
    # bash
    if [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]]; then
      . "/opt/homebrew/etc/profile.d/bash_completion.sh"
    fi
    # git
    if [[ -r "/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash" ]]
    then
      . "/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash"
    fi
    ;;

  Linux)
    # bash
    if [[ -r "/etc/bash_completion" ]]; then
      . "/etc/bash_completion"
    elif [[ -r "/usr/share/bash-completion/bash_completion" ]]; then
      . "/usr/share/bash-completion/bash_completion"
    fi
    # git
    if [[ -r "/usr/share/bash-completion/completions/git" ]]; then
      . "/usr/share/bash-completion/completions/git"
    elif [[ -r "/etc/bash_completion.d/git" ]]; then
      . "/etc/bash_completion.d/git"
    fi
    ;;
esac

################################################################################
# PROMPT ツ❯
case "$OS" in
  Darwin)
    if [[ -r "/Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh" ]]; then
      . "/Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh"
    fi
    ;;

  Linux)
    if [[ -r "/usr/lib/git-core/git-sh-prompt" ]]; then
      . "/usr/lib/git-core/git-sh-prompt"
    fi
    ;;
esac

# Colors
black="\[\033[30m\]"
red="\[\033[31m\]"
green="\[\033[32m\]"
yellow="\[\033[33m\]"
blue="\[\033[34m\]"
magenta="\[\033[35m\]"
cyan="\[\033[36m\]"
white="\[\033[37m\]"
reset="\[\033[0m\]"

__venv_info() {
  [ -n "$VIRTUAL_ENV" ] && printf " py:%s" "$(basename "$VIRTUAL_ENV")"
}

__branch_info() {
  local branch
  branch=$(__git_ps1 "%s")
  [ -n "$branch" ] && printf " git:%s" "$branch"
}

__build_prompt() {
  local venv git extra
  venv="$(__venv_info)"
  git="$(__branch_info)"
  extra="${venv}${git}"

  PS1="[${reset}${cyan}\u@\h${reset}${white}:${reset}${blue}\W${reset}"
  PS1+="${magenta}${venv}${reset}"
  PS1+="${yellow}${git}${reset}]"

  if [[ ${#extra} -gt 8 ]]; then
    PS1+="\n> "
  else
    PS1+="> "
  fi
}

PROMPT_COMMAND='__build_prompt; history -a; history -n'

################################################################################
# SHELL OPTIONS
shopt -s no_empty_cmd_completion
shopt -s checkwinsize

################################################################################
# FZF
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --bash)"
fi

################################################################################
# HOMEBREW
brew() {
  if [[ "$1" == "tap" ]]; then
    echo "Adding new taps is not allowed!"
    return 1
  else
    command brew "$@"
  fi
}

################################################################################
# POSTGRESQL
if command -v psql >/dev/null 2>&1; then
  psql() {
    command psql -h localhost -p 5432 -U postgres -d postgres "$@"
  }
fi

################################################################################
# ALIAS
# common (macOS and linux)
alias vi="nvim"
alias ls="ls -hD '%F %T' --color=auto"
alias ll="ls -alF"
alias lg="lazygit"
alias tree="tree -C --dirsfirst"
alias pathlist='echo "$PATH" | tr ":" "\n"'
# os specific
if [[ "$OS" == "Darwin" ]]; then
  # aws
  alias awslocal='aws --profile localstack'
  # lima aliases
  alias docker='lima nerdctl'
  alias lmake="lima make"
  alias lcmake="lima cmake"
  alias lctest="lima ctest"
  alias lnpsql='lima nerdctl exec -it timescaledb psql -U postgres'
elif [[ "$OS" == "Linux" ]]; then
  # nerdctl aliases
  alias docker='nerdctl'
fi

################################################################################
# TODO SHELL OPTIONS
#  - autocd - change directory without entering the 'cd' command
#  - cdspell - automatically fix directory typos when changing directory
#  - direxpand - automatically expand directory globs when completing
#  - dirspell - automatically fix directory typos when completing
#  - globstar - ** recursive glob
#  - histappend - append to history, don't overwrite
#  - histverify - expand, but don't automatically execute, history expansions
#  - nocaseglob - case-insensitive globbing
#  - no_empty_cmd_completion - do not TAB expand empty lines
# shopt -s autocd cdspell direxpand dirspell globstar histappend histverify \
#     nocaseglob no_empty_cmd_completion
################################################################################
