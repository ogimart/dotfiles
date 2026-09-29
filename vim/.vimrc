vim9script

################################################################################
# GENERAL
filetype plugin indent on
set nocompatible
set encoding=utf-8
set autoread
set nospell
set belloff=all
set spelllang=en
set clipboard=unnamed
set ttimeoutlen=20
set path+=**
set wildmenu
set wildoptions=pum
set completeopt=noinsert,menuone,popup
set completepopup=border:on

################################################################################
# BACKUP
set noswapfile
set nobackup
set nowritebackup

################################################################################
# TABS
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
autocmd FileType python setlocal shiftwidth=4 softtabstop=4

################################################################################
# INDENT
set autoindent
set copyindent
set smartindent

################################################################################
# UI
syntax on
set termguicolors
set signcolumn=yes
set number
set cursorline
set cursorlineopt=number
set fillchars+=vert:│
set scrolloff=5
# Sttatus Line
set laststatus=2
set statusline=%f\ %m%r%=%y\ %l:%c
# Cursor
&t_EI = "\e[2 q" # normal mode steady block
&t_SI = "\e[6 q" # insert mode steady line
&t_SR = "\e[4 q" # replace mode steady underline
# Spechial Chars
set list
set listchars+=eol:\ ,tab:▸\ ,trail:⎵,nbsp:·

################################################################################
# FZF
if isdirectory('/opt/homebrew/opt/fzf')
  set runtimepath+=/opt/homebrew/opt/fzf
elseif isdirectory('/home/linuxbrew/.linuxbrew/opt/fzf')
  set runtimepath+=/home/linuxbrew/.linuxbrew/opt/fzf
endif

################################################################################
# KEYMAP
g:mapleader = "\<space>"
# Quickfix
nnoremap <leader>qo <cmd>copen<cr>
nnoremap <leader>qc <cmd>cclose<cr>
nnoremap ]q <cmd>cnext<cr>
nnoremap [q <cmd>cprevious<cr>
# Location List
nnoremap <leader>lo <cmd>lopen<cr>
nnoremap <leader>lc <cmd>lclose<cr>
nnoremap ]l <cmd>lnext<cr>
nnoremap [l <cmd>lprevious<cr>
# FZF
nnoremap <leader>fb <cmd>Buffers<cr>
nnoremap <leader>fl <cmd>BLines<cr>
nnoremap <leader>ff <cmd>Files<cr>
nnoremap <leader>fg <cmd>Rg<cr>
nnoremap <leader>fs :RG<space>

################################################################################
# COLOR SCHEME
set background=dark
# Catppuccin Theme
colorscheme catppuccin_mocha
v:colornames['cr'] = '#e490a7' # catppuccin red
# Highlight Fix
hi MatchParen cterm=underline
hi Todo guibg=bg guifg=cr
