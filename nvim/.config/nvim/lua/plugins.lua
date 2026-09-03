-- lua/plugins.lua

--------------------------------------------------------------------------------
-- Plugins -- Neovim 0.12 built-in plugin manager (`:h vim.pack`)
--------------------------------------------------------------------------------
--   vim.pack.update()                    update all (confirm :w / abort :q)
--   vim.pack.update({ "telescope.nvim" }) update one
--   vim.pack.update(nil, { offline = true })  browse installed state
--   vim.pack.del({ "name" })             remove from disk
--   :checkhealth vim.pack
--
-- Plugins live in  <stdpath("data")>/site/pack/core/opt/
-- Lockfile lives in <stdpath("config")>/nvim-pack-lock.json  (commit this)

local gh = function(repo) return "https://github.com/" .. repo end
local is_macos = vim.uv.os_uname().sysname == "Darwin"
local is_linux = vim.uv.os_uname().sysname == "Linux"
-- local brew_prefix = vim.fn.system("brew --prefix"):gsub("%s+$", "")

--------------------------------------------------------------------------------
-- Build hooks
--------------------------------------------------------------------------------
-- MUST be registered before the first vim.pack.add() call, otherwise install
-- hooks cannot fire (`:h vim.pack-events`).
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("PackHooks", { clear = true }),
  callback = function(ev)
    local name, kind, path = ev.data.spec.name, ev.data.kind, ev.data.path
    if kind ~= "install" and kind ~= "update" then return end

    -- telescope-fzf-native ships a C library. Build synchronously so that
    -- load_extension("fzf") below works on the very first startup.
    if name == "telescope-fzf-native.nvim" then
      vim.notify("Building telescope-fzf-native ...")
      vim.system({ "make" }, { cwd = path }):wait()
    end
  end,
})

--------------------------------------------------------------------------------
-- Pre-load settings (lazy.nvim `init = ...`)
--------------------------------------------------------------------------------
-- Vimscript plugins read these globals when their plugin/ files are sourced,
-- so they have to be set before that happens.

-- asyncrun.vim
vim.g.asyncrun_open = 8

-- asynctasks.vim
vim.g.asynctasks_term_pos = "bottom"
vim.g.asynctasks_term_focus = 0
vim.g.asynctasks_profile = "release"

-- vim-floaterm
vim.g.floaterm_keymap_toggle = "<leader>tt"
vim.g.floaterm_keymap_kill = "<leader>tx"

-- vim-dadbod
vim.g.db = "postgresql://postgres:postgres@localhost:5432/postgres"

-- vimtex
vim.g.vimtex_view_method = "skim"
vim.g.vimtex_mappings_enabled = 1
vim.g.vimtex_compiler_latexmk = {
  build_dir = "build",
  options = { "-cd", "-auxdir=build" },
  callback_options = { texinputs = "shared//:" },
}
vim.g.vimtex_compiler_latexmk_engines = {
  ["_"] = "-lualatex",
}

--------------------------------------------------------------------------------
-- Install & load
--------------------------------------------------------------------------------
-- There is no dependency resolution: list dependencies before their dependents.
vim.pack.add({
  ------------------------------------------------------------------------------
  -- UI
  ------------------------------------------------------------------------------
  -- repo is called "nvim", so give it an explicit name
  { src = gh("catppuccin/nvim"), name = "catppuccin" },
  gh("nvim-lualine/lualine.nvim"),

  ------------------------------------------------------------------------------
  -- Editing
  ------------------------------------------------------------------------------
  gh("tpope/vim-surround"),
  gh("tpope/vim-repeat"),

  ------------------------------------------------------------------------------
  -- Fuzzy finder
  ------------------------------------------------------------------------------
  gh("nvim-lua/plenary.nvim"),
  gh("nvim-telescope/telescope-fzf-native.nvim"),
  gh("nvim-telescope/telescope.nvim"),

  ------------------------------------------------------------------------------
  -- Async tasks
  ------------------------------------------------------------------------------
  gh("skywind3000/asyncrun.vim"),
  gh("skywind3000/asynctasks.vim"),

  ------------------------------------------------------------------------------
  -- Floating terminal
  ------------------------------------------------------------------------------
  gh("voldikss/vim-floaterm"),

  ------------------------------------------------------------------------------
  -- Database
  ------------------------------------------------------------------------------
  gh("tpope/vim-dotenv"),
  gh("tpope/vim-dadbod"),
  gh("kristijanhusak/vim-dadbod-completion"),

  ------------------------------------------------------------------------------
  -- Completion
  ------------------------------------------------------------------------------
  gh("hrsh7th/cmp-buffer"),
  gh("hrsh7th/cmp-path"),
  gh("hrsh7th/cmp-nvim-lsp"),
  gh("hrsh7th/cmp-nvim-lsp-signature-help"),
  gh("hrsh7th/nvim-cmp"),

  ------------------------------------------------------------------------------
  -- LSP
  ------------------------------------------------------------------------------
  gh("neovim/nvim-lspconfig"),

  ------------------------------------------------------------------------------
  -- OpenCode
  ------------------------------------------------------------------------------
  {
    src = gh("nickjvandyke/opencode.nvim"),
    version = vim.version.range("*"), -- Latest stable release
  },

  ------------------------------------------------------------------------------
  -- LaTeX
  ------------------------------------------------------------------------------
  gh("lervag/vimtex"),
})

--------------------------------------------------------------------------------
-- lualine
--------------------------------------------------------------------------------
require("lualine").setup({
  options = {
    icons_enabled        = false,
    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },
  },
  sections = {
    lualine_c = { { "filename", path = 1 } },
  },
  inactive_sections = {
    lualine_c = { { "filename", path = 1 } },
  },
})

--------------------------------------------------------------------------------
-- Telescope
--------------------------------------------------------------------------------
require("telescope").setup({
  defaults = {
    file_ignore_patterns = {
      "%.git/", "build/", "_build/", "target/",
      "venv/", "__pycache__/", "dist/",
      "node_modules/", "vendor/",
    },
  },
  pickers = {
    find_files = { follow = true, hidden = true },
    live_grep = {
      additional_args = function(_)
        return { "--follow", "--hidden" }
      end,
    },
  },
})
pcall(require("telescope").load_extension, "fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, {})
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fl", builtin.loclist, {})
vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})

--------------------------------------------------------------------------------
-- Async tasks
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>ra", ":AsyncRun ", {})
vim.keymap.set("n", "<leader>rx", ":AsyncStop<cr>", {})
vim.keymap.set("n", "<leader>rl", ":AsyncTaskList<cr>", {})
vim.keymap.set("n", "<leader>re", ":AsyncTaskEdit<cr>", {})
vim.keymap.set("n", "<leader>rt", ":AsyncTask ", {})
vim.keymap.set("n", "<leader>rp", ":AsyncTaskProfile ", {})

--------------------------------------------------------------------------------
-- Floating terminal
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>lg",
  "<cmd>FloatermNew --height=0.95 --width=0.95 lazygit<CR>",
  { noremap = true, silent = true, desc = "lazygit" })
vim.keymap.set("n", "<leader>py",
  "<cmd>FloatermNew --height=0.95 --width=0.95 python3<CR>",
  { noremap = true, silent = true, desc = "python" })
-- vim.keymap.set("n", "<leader>af",
--   "<cmd>FloatermNew --height=0.95 --width=0.95 opencode<CR>",
--   { noremap = true, silent = true, desc = "opencode" })

--------------------------------------------------------------------------------
-- Database
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>db", "<cmd>%DB<CR>", { desc = "Execute SQL buffer" })
vim.keymap.set("v", "<leader>ds", ":DB<CR>", { desc = "Execute selected SQL" })

--------------------------------------------------------------------------------
-- Completion
--------------------------------------------------------------------------------
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered({ border = "rounded" }),
    documentation = cmp.config.window.bordered({ border = "rounded" }),
  },
  -- window = {
  --   completion = cmp.config.window.bordered(),
  --   documentation = cmp.config.window.bordered(),
  -- },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
  formatting = {
    fields = { "menu", "abbr", "kind" },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = "[λ]",
        buffer = "[β]",
        path = "[π]",
        ["vim-dadbod-completion"] = "[db]",
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
})
cmp.setup.filetype({ "sql", "plsql" }, {
  sources = {
    { name = "vim-dadbod-completion" },
    { name = "buffer" },
  },
})

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, silent = true, noremap = true }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
end

-- LSP Servers --

local clangd_cmd

if is_macos then
  -- Apple clangd --
  -- clangd_cmd = { "clangd" }

  -- LLVM clangd --
  -- local llvm_ver = 22
  -- local llvm_prefix = vim.fn.system("brew --prefix llvm@" .. llvm_ver):gsub("%s+$", "")
  -- clangd_cmd = { llvm_prefix .. "/bin/clangd", }

  -- Lima VM --
  -- local gcc_ver = 15
  local clang_ver = 22
  clangd_cmd = {
    "lima", "/usr/bin/clangd-" .. clang_ver,
    -- gnu gcc driver --
    -- "--query-driver=/usr/bin/gcc-" .. gcc_ver .. "," .. "/usr/bin/g++-" .. gcc_ver,
  }
elseif is_linux then
  local gcc_ver = 15
  local clang_ver = 22
  clangd_cmd = {
    "/usr/bin/clangd-" .. clang_ver,
    -- gnu gcc driver --
    "--query-driver=/usr/bin/gcc-" .. gcc_ver .. "," .. "/usr/bin/g++-" .. gcc_ver,
  }
end

local servers = {
  -- C and C++
  clangd = {
    cmd = clangd_cmd,
  },
  -- Rust
  rust_analyzer = {
    cmd = { "rust-analyzer" },
    -- cmd = { "lima", "rust-analyzer" },
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = true,
        check = {
          command = "clippy",
          allTargets = true,
        },
      },
    },
  },
  -- Python
  pyright = {
    settings = {
      pyright = {
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          typeCheckingMode = "basic", -- "strict"
          diagnosticMode = "workspace",
          autoSearchPaths = true,
        },
      },
    },
  },
  ruff = {
    cmd = { "ruff", "server", "--preview" },
    filetypes = { "python" },
    init_options = {
      settings = {
        capabilities = { hoverProvider = false },
      },
    },
  },
  -- TypeScript: deno wins where a deno.json exists, ts_ls elsewhere.
  -- Not calling on_dir() prevents the server from starting at all.
  denols = {
    root_dir = function(bufnr, on_dir)
      local root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
      if root then on_dir(root) end
    end,
    init_options = {
      enable = true,
      lint = true,
      unstable = true,
    },
  },
  ts_ls = {
    root_dir = function(bufnr, on_dir)
      if vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) then return end
      local root = vim.fs.root(bufnr, { "package.json", "tsconfig.json" })
      if root then on_dir(root) end
    end,
  },
  -- LaTeX
  texlab = {},
  -- Lua (neovim)
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
      },
    },
  },
}

for name, config in pairs(servers) do
  config.capabilities = capabilities
  config.on_attach = on_attach
  vim.lsp.config(name, config)
end
vim.lsp.enable(vim.tbl_keys(servers))

--------------------------------------------------------------------------------
-- OpenCode
--------------------------------------------------------------------------------
-- TODO

--------------------------------------------------------------------------------
-- Colorscheme
--------------------------------------------------------------------------------
vim.cmd.colorscheme("catppuccin-mocha")
vim.api.nvim_set_hl(0, "Todo", { fg = "#e490a7", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "MatchParen", { fg = "#ffffff", bg = "NONE", underline = true })

--------------------------------------------------------------------------------
-- Convenience commands (lazy.nvim's `:Lazy` replacement)
--------------------------------------------------------------------------------
vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, { desc = "Update all plugins" })

vim.api.nvim_create_user_command("PackStatus", function()
  vim.pack.update(nil, { offline = true })
end, { desc = "Show installed plugins without fetching" })
