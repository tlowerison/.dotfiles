-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- lodash of neovim
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-telescope/telescope.nvim")
  use("hrsh7th/nvim-cmp") -- code completion


  use("akinsho/bufferline.nvim")

  use("neovim/nvim-lspconfig")

  use("nvim-tree/nvim-web-devicons")

  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly" -- optional, updated every week. (see issue #1193)
  })

  use("nvim-treesitter/nvim-treesitter")

  use("sam4llis/nvim-tundra")

  use("nvim-tree/nvim-web-devicons")

  use("simrat39/rust-tools.nvim")

  use({ "mg979/vim-visual-multi", branch = "master" })

end)
