# ~/.zprofile

# Automatically keep PATH entries unique (prevents duplication in tmux)
typeset -U PATH path

# Load environment
[ -f "$HOME/.env" ] && . "$HOME/.env"

# .zprofile --- eof
