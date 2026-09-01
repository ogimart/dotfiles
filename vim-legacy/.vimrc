vim9script

################################################################################
# PLUGINS
plug#begin()
# Editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
# # Git
Plug 'tpope/vim-fugitive'
# Environment
Plug 'tpope/vim-dotenv'
# Database
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-completion'
# Async Task
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim'
# Terminal
Plug 'voldikss/vim-floaterm'
# # Fuzzy Finder
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
# # LSP
Plug 'yegappan/lsp'
# AI Completion TODO
# Plug 'Exafunction/windsurf.vim', { 'branch': 'main' }
# Colorscheme
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
# # Statusline
Plug 'itchyny/lightline.vim'
plug#end()

################################################################################
# GENERAL
filetype plugin indent on
set nocompatible
set encoding=utf-8
set autoread
set nospell
set belloff=all
set spelllang=en
set re=0
set clipboard=unnamed
set ttimeoutlen=20
set path+=**
set wildmenu
set wildoptions=pum
set completeopt=noinsert,menuone,popup
set completepopup=border:off

################################################################################
# BACKUP
set noswapfile
set nobackup
set nowb

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
set noshowmode
set number
set cursorline
set cursorlineopt=number
set fillchars+=vert:│
set laststatus=2
set scrolloff=5
# Cursor
&t_EI = "\e[2 q" # normal mode steady block
&t_SI = "\e[6 q" # insert mode steady line
&t_SR = "\e[4 q" # replace mode steady underline
# Spechial Chars
set list
set listchars+=eol:\ ,tab:▸\ ,trail:⎵,nbsp:·

################################################################################
# STATUS LINE
g:lightline = {
  'active': {
    'left': [['mode', 'paste'],
             ['gitbranch', 'readonly', 'filename', 'modified']]
  },
  'component_function': { 'gitbranch': 'FugitiveHead' },
}

################################################################################
# FZF
g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

################################################################################
# ASYNCRUN
g:asyncrun_open = 8

################################################################################
# LSP
set keywordprg=:LspHover
g:lspLogLevel = 'debug'
g:lspLogFile = '/tmp/lsp.log'

var lspOpts = {
  autoComplete: v:true,
  omniComplete: v:true,
  useBufferCompletion: v:true,
  autoHighlightDiags: v:true,
  ignoreMissingServer: v:true,
  diagSignErrorText: '✘',
  diagSignWarningText: '⚑',
  diagSignHintText: '▲',
  diagSignInfoText: '»',
  showDiagInPopup: v:false,
  showDiagOnStatusLine: v:true,
  useQuickfixForLocations: v:true,
  hoverInPreview: v:false, # ctrl-e/y scroll down/up
  debug: v:true
}
autocmd User LspSetup g:LspOptionsSet(lspOpts)

var lspServers = [
  # {
  #   name: 'rust-analyzer',
  #   filetype: ['rust'],
  #   path: 'rust-analyzer',
  #   args: [],
  #   syncInit: v:true,
  #   settings: {
  #     'rust-analyzer': {
  #       'checkOnSave': {
  #         'command': 'clippy'
  #       }
  #     }
  #   }
  # },
  {
    name: 'pyright',
    filetype: ['python'],
    path: 'pyright-langserver',
    args: ['--stdio'],
    initializationOptions: {
      'pyright': {
        'disableOrganizeImports': v:false
      }
    }
  },
  # {
  #   name: 'ruff',
  #   filetype: ['python'],
  #   path: 'ruff',
  #   args: ['server', '--preview'],
  #   initializationOptions: {
  #     'settings': {
  #       'capabilities': {
  #         'hoverProvider': v:false
  #       }
  #     }
  #   }
  # },
  # {
  #   name: 'deno',
  #   filetype: ['typescript'],
  #   path: 'deno',
  #   args: ['lsp'],
  #   debug: v:true,
  #   initializationOptions: {
  #     'enable': v:true,
  #     'lint': v:true
  #   }
  # }
]
autocmd User LspSetup g:LspAddServer(lspServers)

augroup LspAutoFormat
  autocmd!
  autocmd BufWritePre *.rs,*.py,*.ts :LspFormat
augroup END

################################################################################
# AI Completion TODO
# g:codeium_disable_bindings = 0
# g:codeium_filetypes = {
#   "rust": v:true,
#   "python": v:true,
#   "typescript": v:true,
# }

################################################################################
# DOTENV
autocmd BufEnter * if filereadable('.env') | silent! execute 'Dotenv' | endif

################################################################################
# DADBOD
if exists('*DotenvGet')
  g:db = DotenvGet('DADBOD_URL')
endif
autocmd FileType sql,plsql setlocal omnifunc=vim_dadbod_completion#omni

################################################################################
# KEYMAP
g:mapleader = "\<space>"
# FZF
nnoremap <leader>fb <cmd>Buffers<cr>
nnoremap <leader>fs <cmd>BLines<cr>
nnoremap <leader>ff <cmd>Files<cr>
nnoremap <leader>fr <cmd>Rg<cr>
nnoremap <leader>fg :RG<space>
nnoremap <leader>fh <cmd>Helptags<cr>
nnoremap <leader>fq <cmd>copen<cr><cmd>BLines<cr>
nnoremap <leader>fl <cmd>lopen<cr><cmd>BLines<cr>
# Floaterm
nnoremap <leader>lg <cmd>FloatermNew --height=0.95 --width=0.95 lazygit<cr>
nnoremap <leader>tt <cmd>FloatermToggle<cr>
nnoremap <leader>tx <cmd>FloatermKill<cr>
# Async Run/Task
nnoremap <leader>ra :AsyncRun<space>
nnoremap <leader>rx <cmd>AsyncStop<cr>
nnoremap <leader>rt :AsyncTask<space>
nnoremap <leader>rl <cmd>AsyncTaskList<cr>
nnoremap <leader>re <cmd>AsyncTaskEdit<cr>
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
# LSP
nnoremap gd <cmd>LspGotoDefinition<cr>
nnoremap gD <cmd>LspGotoTypeDef<cr>
nnoremap <leader>gi <cmd>LspGotoImpl<cr>
nnoremap gr <cmd>LspShowReferences<cr>
nnoremap <leader>rn <cmd>LspRename<cr>
nnoremap <leader>ca <cmd>LspCodeAction<cr>
nnoremap <leader>cf <cmd>LspFormat<cr>
nnoremap <leader>cd <cmd>LspDiag show<cr>
nnoremap ]d <cmd>LspDiag next<cr>
nnoremap [d <cmd>LspDiag prev<cr>
nnoremap gp <cmd>LspPeekDefinition<cr>
nnoremap <leader>ss <cmd>LspSymbolSearch<cr>
nnoremap <leader>so <cmd>LspDocumentSymbol<cr>
nnoremap <leader>ic <cmd>LspIncomingCalls<cr>
nnoremap <leader>oc <cmd>LspOutgoingCalls<cr>

################################################################################
# COLOR THEME
set background=dark
# Catppuccin Theme
colorscheme catppuccin_mocha
g:lightline.colorscheme = 'catppuccin_mocha'
v:colornames['cr'] = '#e490a7' # catppuccin red
v:colornames['cy'] = '#f5c2e7' # catppuccin yellow
# Highlight Fix
hi MatchParen cterm=underline
hi Todo guibg=bg guifg=cr
# Highlight LSP Fix
hi LspDiagInlineInfo guibg=bg
hi LspDiagInlineHint guibg=bg
hi LspDiagInlineWarning guibg=bg
hi LspDiagInlineError guibg=bg cterm=underline
hi LspDiagSignInfoText guibg=bg
hi LspDiagSignHintText guibg=bg
hi LspDiagSignWarningText guibg=bg guifg=cy
hi LspDiagSignErrorText guibg=bg guifg=cr
