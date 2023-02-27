# .zshrc
#
# This is a generated file from ~/.dotfiles/zsh.org
# Do not edit!

autoload -Uz compinit colors vcs_info
precmd() { vcs_info }

setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt CORRECT_ALL
setopt prompt_subst
unsetopt beep

bindkey -e
export KEYTIMEOUT=1

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

zstyle ':vcs_info:git:*' formats $' %F{cyan}%b%u%c%f'
zstyle ':vcs_info:git:*' actionformats 'g:%b|%a%u%c'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ':*'
zstyle ':vcs_info:*' stagedstr ':+'

export VIRTUAL_ENV_DISABLE_PROMPT=0

function venv_info {
    [ $VIRTUAL_ENV ] && echo '%F{blue}'`basename $VIRTUAL_ENV`'%f '
}

PS1='%F{white}[%f'
PS1+='$(venv_info)'
PS1+='%F{magenta}%(4~|.../%2~|%~)%f'
PS1+='${vcs_info_msg_0_}'
PS1+=$'%F{white}]>%f '
RPROMPT=''

zstyle ':completion:*' completer _complete _correct _approximate
fpath=(~/.zsh/completion $fpath)
compinit

colors
export CLICOLOR=1

export EDITOR=vi
export VISUAL=vi
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!{.git,node_modules,vendor,target,build,out}/*"'
export FZF_DEFAULT_OPTS="--no-bold --color=dark,bg:black,bg+:black"

alias ll='exa -gal --git --sort=type --time-style=long-iso'
alias tree='exa -a --tree --sort=type --ignore-glob=.git'
alias bat='bat --theme=base16'
alias vi='nvim'
alias em='emacs $@'
alias ec='emacsclient $@'
alias clion='open -na "CLion.app" --args "$@"'
alias intellij='open -na "IntelliJ IDEA.app" --args "$@"'
alias goland='open -na "GoLand.app" --args "$@"'

if [[ "$INSIDE_EMACS" = 'vterm' ]] \
    && [[ -f ~/.config/zsh/vterm-zsh.sh ]]; then
	source ~/.config/emacs/vterm-zsh.sh
fi
