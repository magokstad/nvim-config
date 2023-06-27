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
  'wbthomason/packer.nvim',
  "nvim-lua/plenary.nvim",

  -- Cosmetics
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'goolord/alpha-nvim',
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- opts = { require'alpha.themes.startify'.config }
  },

  -- Zen
  "folke/twilight.nvim",
  "folke/zen-mode.nvim",

  -- Fuzzy find etc
  'nvim-telescope/telescope.nvim',
  "folke/which-key.nvim",

  -- Git
  'lewis6991/gitsigns.nvim',

  -- Language stuff
  "folke/neodev.nvim",

  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "jose-elias-alvarez/null-ls.nvim",
  "jayp0521/mason-null-ls.nvim",

  {
	  "nvim-treesitter/nvim-treesitter",
	  build = ":TSUpdate"
  },
  "gpanders/editorconfig.nvim",
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  "lukas-reineke/lsp-format.nvim",

  -- Parinfer
  'eraserhd/parinfer-rust',

  -- Editor-config
  "gpanders/editorconfig.nvim",


  -- Comments
  {
    'numToStr/Comment.nvim',
    config = true
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- Completion (oh boy, this is a big one)
  {
    "L3MON4D3/LuaSnip",
    tag = "v<CurrentMajor>.*"
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      -- 'hrsh7th/cmp-nvim-lua',
      -- 'octaltree/cmp-look',
      'hrsh7th/cmp-path',
      -- 'hrsh7th/cmp-calc',
      -- 'f3fora/cmp-spell',
      -- 'hrsh7th/cmp-emoji',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets'
    }
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = '*',
  },

  -- Wakatime
  "wakatime/vim-wakatime",

  -- Primeagen
  'ThePrimeagen/vim-be-good',

  -- Autopairs
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
  },
}

local opts = {}

require("lazy").setup(plugins, opts)

