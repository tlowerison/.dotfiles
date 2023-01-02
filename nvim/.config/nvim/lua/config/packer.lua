-- This file can be loaded by calling `lua require("plugins")` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- lodash of neovim
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-telescope/telescope.nvim")

  -- code completion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")

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

  use("simrat39/rust-tools.nvim")

  use({"mg979/vim-visual-multi", branch = "master"})

  use {"kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async"}

  use("windwp/nvim-spectre")

  use("airblade/vim-gitgutter")

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true }
  })
  
  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")
  use("RRethy/nvim-treesitter-endwise")

  use("folke/zen-mode.nvim")

  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })
end)
