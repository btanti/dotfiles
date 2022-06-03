-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'dstein64/vim-startuptime'
  use 'tpope/vim-surround'
  use 'windwp/nvim-autopairs'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'onsails/lspkind-nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'quangngyuen30192/cmp-nvim-ultisnips'
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client:
  use "lukas-reineke/indent-blankline.nvim"
  use "ray-x/lsp_signature.nvim"
  use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
}
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
  use 'ryanoasis/vim-devicons'
  use 'preservim/nerdcommenter'
  use 'mhinz/vim-startify'
  use 'itchyny/lightline.vim'
  use {"akinsho/toggleterm.nvim", tag = 'v1.*', config = function()
  require("toggleterm").setup()
 end
  }

require("lspconfig").pyright.setup({})
  -- You can alias plugin names
end)
