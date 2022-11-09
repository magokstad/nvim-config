vim.cmd [[packadd packer.nvim]]

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

return require('packer').startup(function(use)

    -- Requirements++
    use 'wbthomason/packer.nvim'
    use "nvim-lua/plenary.nvim"

    -- Cosmetics
    use 'folke/tokyonight.nvim'
    use {
      'akinsho/bufferline.nvim',
      tag = "v3.*",
      requires = 'nvim-tree/nvim-web-devicons',
      config = function()
        require("bufferline").setup{}
      end
    }
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require("lualine").setup()
      end,
    }
    use {
      'goolord/alpha-nvim',
      config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
      end
    }
    use({
      "folke/noice.nvim",
      config = function()
        require("noice").setup()
      end,
      requires = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
        }
    })

    -- Zen
    use {
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup {
          -- your configuration comes here
        }
      end
    }
    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
          -- your configuration comes here
        }
      end
    }

    -- Fuzzy find etc
    use 'nvim-telescope/telescope.nvim'
    use "folke/which-key.nvim"


    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    }

    -- Language stuff
    use {
      "folke/neodev.nvim",
      config = function ()
        require("neodev").setup()
      end
    }
    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    }
    use "nvim-treesitter/nvim-treesitter"
    use "gpanders/editorconfig.nvim"
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
        }
      end
    }
    use "jose-elias-alvarez/null-ls.nvim"

    -- Comments
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require('todo-comments').setup()
      end
    }

    -- Debugging
    use 'mfussenegger/nvim-jdtls'
    use 'mfussenegger/nvim-dap'

    -- Completion (oh boy, this is a big one)
    use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})
    use {
      "hrsh7th/nvim-cmp",
      requires = {
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
    }

    -- Compiling
    use 'neomake/neomake'
    use {'michaelb/sniprun', run = 'bash install.sh'}

    -- Terminal
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
      require("toggleterm").setup()
    end}

    -- Wakatime
    use "wakatime/vim-wakatime"

    if packer_bootstrap then
      require('packer').sync()
    end
end)
