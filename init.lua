--- VIM_OPTS ---
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.incsearch = true
vim.opt.smartindent = true
vim.opt.textwidth = 80
-- vim.opt.colorcolumn = "82"
vim.opt.wrap = true
vim.g.mapleader = " "
vim.opt.mouse = "a"

--- COLOR_STUFF ---
vim.opt.termguicolors = true
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.opt.background = "dark"
local cscheme = "tokyonight-moon"

--- REMAP_FUNCTIONS ---
local function bind(op, outer_opts)
  outer_opts = outer_opts or { noremap = true }
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force",
      outer_opts,
      opts or {}
    )
    vim.keymap.set(op, lhs, rhs, opts)
  end
end
local nmap = bind("n", { noremap = false })
local nnoremap = bind("n")
local vnoremap = bind("v")
local xnoremap = bind("x")
local inoremap = bind("i")
local tnoremap = bind("t")


--- REMAPS ---
nnoremap("<leader>ff", "<cmd>Telescope find_files<CR>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<CR>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<CR>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<CR>")
nnoremap("<leader>tt", "<cmd>ToggleTerm<CR>")
tnoremap("<Esc>", "<C-\\><C-n>")
nnoremap("<leader>zm", "<cmd>ZenMode<CR>")
nnoremap("<TAB>", "<cmd>BufferLineCycleNext<CR>")
nnoremap("<S-Tab>", "<cmd>BufferLineCycleNext<CR>")
-- TODO: add lsp remaps


--- PLUGINS ---
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
  -- Requirements++
  "nvim-lua/plenary.nvim",
  -- Cosmetics
  {'folke/tokyonight.nvim', lazy = false, priority = 1000,},
  -- Zen
  "folke/twilight.nvim",
  "folke/zen-mode.nvim",
  -- Fuzzy find etc
  'nvim-telescope/telescope.nvim',
  "folke/which-key.nvim",
  {"folke/which-key.nvim", event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,},

  -- Git
  'lewis6991/gitsigns.nvim',
  -- Language stuff
  "folke/neodev.nvim",
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "jose-elias-alvarez/null-ls.nvim",
  "jayp0521/mason-null-ls.nvim",
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  "gpanders/editorconfig.nvim",
  {"folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons",},
  "lukas-reineke/lsp-format.nvim",
  -- Parinfer
  'eraserhd/parinfer-rust',
  -- Editor-config
  "gpanders/editorconfig.nvim",
  -- Comments
  {'numToStr/Comment.nvim', config = true},
  {"folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim",},
  -- Completion (oh boy, this is a big one)
  {"L3MON4D3/LuaSnip", version = "2.*", build = "make install_jsregexp"},
  {"hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets'
    }
  },
  -- Terminal
  {"akinsho/toggleterm.nvim", version = '*', config=true},
  -- Wakatime
  "wakatime/vim-wakatime",
  -- Autopairs
  {'windwp/nvim-autopairs', event = "InsertEnter",},
}
local opts = {}
require("lazy").setup(plugins, opts)

--- AUTOCOMPLETE_SETUP ---
local cmp = require('cmp')
-- local cmp_action = require('lsp-zero').cmp_action()
local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-Up>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Down>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    -- Is this forreal? Why is there no builtin for this???
    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1
      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, { 'i', 's' }),
    -- Is this forreal? Why is there no builtin for this???
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
})
--- LSP_SETUP ---
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)
require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

vim.cmd("colorscheme " .. cscheme)
