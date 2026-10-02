# ~/.zshrc

################################################################################
# OPERATING SYSTEM
OS="$(uname -s)"

################################################################################
# NON-INTERACTIVE CHECK
[[ -o interactive ]] || return
# [[ $TERM == dumb ]] && { unsetopt zle; PS1='%# '; unset RPROMPT; return }

################################################################################
# TERMINAL
export EDITOR=vi
export VISUAL=vi
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

bindkey -e

################################################################################
# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history       # Record timestamp and duration
setopt share_history          # Share history live across panes
setopt hist_expire_dups_first # Expire duplicate entries first when trimming
setopt hist_ignore_all_dups   # Remove older duplicate entries from memory
setopt hist_save_no_dups      # Prevent duplicate entries from being written to disk
setopt hist_ignore_space      # Don't record entries starting with a space
setopt hist_reduce_blanks     # Remove superfluous blanks

################################################################################
# COMPLETION & ZSH ENHANCEMENTS
fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
fpath=("$HOMEBREW_PREFIX/share/zsh-completions" $fpath)

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
# ALIASES
[ -r "$HOME/.aliases" ] && . "$HOME/.aliases"

# ~/.zshrc --- eof
