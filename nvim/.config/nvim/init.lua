-- init.lua

--------------------------------------------------------------------------------
--- Vim
--------------------------------------------------------------------------------
----- vim.g   -- global vim variables
----- vim.opt -- set vim options
----- vim.cmd -- vim commands
----- vim.fn  -- vim functions
----- vim.api -- vim API

--------------------------------------------------------------------------------
-- Leader
--------------------------------------------------------------------------------
-- set before lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--------------------------------------------------------------------------------
-- Lazy Plugin Manager
--------------------------------------------------------------------------------
require("plugins") -- vim.pack
-- require("lazy_config") -- lazy.nvim

--------------------------------------------------------------------------------
--- General
--------------------------------------------------------------------------------
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.scrolloff = 10

--------------------------------------------------------------------------------
--- UI
--------------------------------------------------------------------------------
vim.o.winborder = "rounded"
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.list = true
vim.opt.listchars = "eol: ,tab:▸·,trail:·,nbsp:⎵" -- ⏎,×
vim.opt.background = 'dark'
-- vim.cmd.colorscheme "catppuccin-mocha"
-- vim.api.nvim_set_hl(0, "Todo", { fg = "#e490a7", bg = "NONE", bold = true })
-- vim.api.nvim_set_hl(0, "MatchParen", { bg = "NONE", underline = true })
if vim.env.TMUX then
  vim.o.mouse = ""
end

--------------------------------------------------------------------------------
-- NeoVim RPC Provider
--------------------------------------------------------------------------------
vim.g.lua_host_prog = 'lua5.1'
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

--------------------------------------------------------------------------------
-- Tabs
--------------------------------------------------------------------------------
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

--------------------------------------------------------------------------------
-- Diagnostic
--------------------------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  underline = true,
  float = {
    border = 'rounded',
    source = 'if_many',
  },
  signs = {
    active = true,
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN]  = '▲',
      [vim.diagnostic.severity.HINT]  = '⚑',
      [vim.diagnostic.severity.INFO]  = '»',
    },
  }
})

--------------------------------------------------------------------------------
-- Format on Save
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.cpp", "*.hpp", "*.cppm", "*.ixx", "*.c", "*.h",
    "*.py", "*.lua", "*.js", "*.ts", "*.rs", ".tex" },
  group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
  callback = function()
    if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
      vim.lsp.buf.format({ async = false })
    end
  end,
})

--------------------------------------------------------------------------------
-- Filetypes
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ixx",
  command = "set filetype=cpp"
})

--------------------------------------------------------------------------------
-- Keymap
--------------------------------------------------------------------------------
-- Quickfix list
vim.keymap.set("n", "<leader>qo", "<cmd>copen<cr>", { desc = "Open quickfix" })
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<cr>", { desc = "Close quickfix" })
-- Location list
vim.keymap.set("n", "<leader>lo", "<cmd>lopen<cr>", { desc = "Open loclist" })
vim.keymap.set("n", "<leader>lc", "<cmd>lclose<cr>", { desc = "Close loclist" })
-- Terminal
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- Other
vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<cr>", { desc = "Stop highlighting search" })

--------------------------------------------------------------------------------
-- OmniComplete (replaced by nvim-cmp)
--------------------------------------------------------------------------------
-- vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
-- vim.opt.completeopt = {'noinsert', 'menuone', 'noselect', 'preview'}
-- vim.cmd [[ autocmd CompleteDone * pclose ]]
--------------------------------------------------------------------------------
