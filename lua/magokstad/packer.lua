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

    -- Fuzzy find etc
    use 'nvim-telescope/telescope.nvim'
    use "folke/which-key.nvim"

    -- Language stuff
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
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    -- Comments
    use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
    }


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
