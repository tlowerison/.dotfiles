local api = vim.api
local g = vim.g
local opt = vim.opt

local M = {}

g.mapleader = " "

-- opt.guicursor = ""

opt.nu = true
opt.relativenumber = true

opt.errorbells = false

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.clipboard = "unnamedplus"

opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

-- Give more space for displaying messages.
opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
opt.updatetime = 50

-- Don"t pass messages to |ins-completion-menu|.
opt.shortmess:append("c")

-- opt.colorcolumn = "80"

-- Code Folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.fillchars = "fold: "
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

