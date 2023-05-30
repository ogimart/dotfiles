# TERMINAL ENV
export CLICOLOR=1
export EDITOR=vi
export VISUAL=vi
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

# PROMPT
PROMPT_DIRTRIM=2
export VIRTUAL_ENV_DISABLE_PROMPT=0

function git_branch() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  [ $BRANCH ] && echo " ${BRANCH}"
}

function virtenv_info {
  [ $VIRTUAL_ENV ] && echo ''`basename $VIRTUAL_ENV`' '
}

export PS1="[\e[95m\`virtenv_info\`\e[94m\w\e[96m\`git_branch\`\e[0m]$ "

# ALIAS
# list
alias ls='exa'
alias ll='exa -al --git --sort=type --time-style=long-iso'
alias tree='exa --tree --ignore-glob=.git'
# edit
alias vi='nvim'
alias em='emacs $@'
alias ew='emacs -nw $@'
alias ec='emacsclient $@'
alias clion='open -na "CLion.app" --args "$@"'
alias intellij='open -na "IntelliJ IDEA.app" --args "$@"'
alias goland='open -na "GoLand.app" --args "$@"'

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!{.git,node_modules,vendor,target,build,out}/*"'
source ~/.config/themes/base16-fzf/bash/base16-tokyo-night-dark.config
