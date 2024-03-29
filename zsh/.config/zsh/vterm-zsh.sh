vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
}
setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ]); then
	# Tell tmux to pass the escape sequences through
	printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    else
	printf "\e]%s\e\\" "$1"
    fi
}

vterm_cmd() {
    local vterm_elisp
    vterm_elisp=""
    while [ $# -gt 0 ]; do
	vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
	shift
    done
    vterm_printf "51;E$vterm_elisp"
}

find_file() {
  vterm_cmd find-file "$(realpath "${@:-.}")"
}

alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
alias ff='find_file'

if [[ "$EMACS_THEME" == "light" ]]; then
  export FZF_DEFAULT_OPTS="--color=16,bg:#ffffff,bg+:#ffffff"
else
  export FZF_DEFAULT_OPTS="--color=16,bg:#000000,bg+:#000000"
fi
