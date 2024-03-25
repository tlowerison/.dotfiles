-- Basic configuration settings
-- -----------------------------------------------
vim.opt.autowrite      = true      -- write current buffer when moving buffers
vim.opt.background     = "dark"    -- background mode
vim.opt.backup         = false     -- no backup made of unsaved changes
vim.opt.cmdheight      = 1         -- give more space for displaying messages
vim.opt.completeopt    = "menu,menuone,noselect" -- set complete options to use nvim-cmp
vim.opt.cursorline     = true      -- highlight current line
vim.opt.errorbells     = false     -- literally no one likes error bells
vim.opt.expandtab      = true      -- in insert mode, replace tab with the appropriate number of spaces
vim.opt.fillchars      = "fold: "  -- fill folded code with empty space
vim.opt.foldcolumn     = "0"       -- disable fold level numbers in gutter
vim.opt.foldenable     = true      -- fold text by default when opening files
vim.opt.foldlevel      = 99        -- initial fold level is so large, appears unfolded
vim.opt.foldlevelstart = 99        -- initial fold level is so large, appears unfolded
vim.opt.foldmethod     = "expr"    -- `foldexpr` gives the fold level of a line
vim.opt.foldexpr       = "nvim_treesitter#foldexpr()"
vim.opt.hlsearch       = false     -- don't highlight search results
vim.opt.incsearch      = true      -- jump to search results as search string is being typed
vim.opt.isfname:append("@-@")      -- include the character "@" in pathnames (neded for fuzzy finder, etc.)
vim.opt.laststatus     = 3         -- only display one status line rather than one per window
vim.opt.linebreak      = true      -- break lines at words
vim.opt.number         = true      -- show line numbers
vim.opt.relativenumber = true      -- show relative linenumbers (can be toggled with "<leader>1")
vim.opt.ruler          = true	     -- shows cursor position in current line
vim.opt.scrolloff      = 8         -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.shiftwidth     = 2         -- default indentation width is 2 spaces
vim.opt.shortmess:append("c")      -- don't pass messages to |ins-completion-menu|
vim.opt.showcmd        = true	     -- shows partially typed commands
vim.opt.showmode       = false     -- disable in favor of lualine/lightline statusline
vim.opt.signcolumn     = "yes"     -- enable LSP diagnostic symbols in left column
vim.opt.smartindent    = true      -- smart autoindent when starting a new line
vim.opt.softtabstop    = 2         -- similar to shiftwidth + expandtab
vim.opt.swapfile       = false     -- swapfiles will not be used for buffers, prevents huge files from being loaded into memory
vim.opt.tabstop        = 2         -- similar to shfitwidth + expandtab
vim.opt.undodir        = os.getenv("HOME") .. "/.vim/undodir" -- base path for undo files
vim.opt.undofile       = true      -- use files for undos
vim.opt.updatetime     = 100
vim.opt.wrap           = false     -- do not wrap long lines

vim.g.mapleader             = " " -- set global leader key
vim.g.terraform_fmt_on_save = 1
vim.g.terraform_align       = 1
vim.g.vimtex_view_enabled   = 1
vim.g.vimtex_view_method    = "skim"
vim.g.compiler_method       = "latexmk"
-- vim.g.vimtex_view_general_viewer = "okular"
-- vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"

-- use system clipboard for yanks
if vim.fn.has("unnamedplus") then
  vim.opt.clipboard = "unnamedplus"
else if vim.fn.executable("xsel") == 1 then
  vim.opt.clipboard = {                 
    name = "xsel",
    copy = {
      ["+"] = "xsel --nodetach -ib",
      ["*"] = "xsel --nodetach -ip"
    },
    paste = {
      ["+"] = "xsel -ob",
      ["*"] = "xsel -op"
    },
    cache_enabled = true,
  }
end

if vim.fn.has("termguicolors") == 1 then
  vim.opt.termguicolors = true
end

-- change to "debug" if needed
-- output is sent to "$HOME/.local/state/nvim/lsp.log"
-- logs need to be cleared out every once in a while
vim.lsp.set_log_level("off")

-- Load plugins
-- --------------------------------------------- --
require("packer").startup(function(use)
  -- packer manages itself
  use("wbthomason/packer.nvim")

  -- lodash of neovim
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-telescope/telescope.nvim")

  -- code completion
  use("hrsh7th/nvim-cmp") -- code completion engine
  use("hrsh7th/cmp-nvim-lsp") -- language server completions
  use("hrsh7th/cmp-buffer") -- current buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- commandline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
 
  -- snippets mechanism
  use("L3MON4D3/LuaSnip")
  -- snippet database
  use("rafamadriz/friendly-snippets")

  -- bufferline
  use("akinsho/bufferline.nvim")

  -- language servers
  use("neovim/nvim-lspconfig") -- lsp client configuration
  use("jose-elias-alvarez/null-ls.nvim") -- adapt non-lsp servers to be used with the neovim lsp client
  use("tlowerison/toggle-lsp-diagnostics.nvim")

  -- icons, needed for displaying icons in bufferline
  use("nvim-tree/nvim-web-devicons")

  -- filetree sidebar
  use({
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
  })

  -- syntax parsing
  use("nvim-treesitter/nvim-treesitter")

  -- theme
  use("sam4llis/nvim-tundra")
  use({ "catppuccin/nvim", as = "catppuccin" })

  -- rust-tools
  use("simrat39/rust-tools.nvim")

  -- multi cursor
  use({"mg979/vim-visual-multi", branch = "master"})

  -- subdued code folding appearance
  use({"kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async"})

  use("folke/twilight.nvim")

  -- recursive find and replace
  use("windwp/nvim-spectre")

  -- display line-level git changes in gutter to left of line numbers
  use("airblade/vim-gitgutter")

  -- display vim status info in a line below buffer content
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
  })
 
  -- automatch enclosing parentheses, brackets, braces, etc.
  use("windwp/nvim-autopairs")

  -- automatch enclosing html tags
  use("windwp/nvim-ts-autotag")

  -- treesitter extension for identifying closing parentheses, etc.
  -- useful for codefolding using treesitter fold expression
  use("RRethy/nvim-treesitter-endwise")

  -- zen mode baby
  use("tlowerison/zen-mode.nvim")

  -- markdown preview in default browser
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })

  -- latex support in neovim
  -- use("latex-lsp/texlab")
  use("lervag/vimtex")

  -- Cargo.toml auxiliary support
  use({
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  })

  -- git-worktree management (integrates with telescope)
  use("ThePrimeagen/git-worktree.nvim")

  -- general purpose golang plugin
  use("fatih/vim-go")

  -- delete multiple buffers with queries
  use("kazhala/close-buffers.nvim")

  -- terraform syntax highlighting
  use("hashivim/vim-terraform")

  -- project local configurations for language servers
  use("folke/neoconf.nvim")

  -- surf through your document and move elements around using the nvim-treesitter API
  use("ziontee113/syntax-tree-surfer")

  -- adds vscode-like pictograms to neovim built-in lsp
  use("onsails/lspkind.nvim")

  -- copilot server and snippet generation
  use("zbirenbaum/copilot.lua")

  -- copilot integration into nvim-cmp
  use({ "zbirenbaum/copilot-cmp", after = {"copilot.lua"} })
end)
-- --------------------------------------------- --


-- Keybindings
-- --------------------------------------------- --

-- easier edit command
vim.keymap.set("n", "<Leader>e", ":edit ")

-- easier help command
vim.keymap.set("n", "<Leader>h", ":help ")

-- easier redo command
vim.keymap.set("n", "U", "<C-r>")

-- easier page up
vim.keymap.set("n", "<leader>j", "<C-b>")

-- easier page down
vim.keymap.set("n", "<leader>k", "<C-f>")

-- delete/paste without yanking
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>p", '"_dP')
vim.keymap.set("v", "<leader>p", '"_dP')

-- insert empty line above and return to original cursor position
function insert_empty_line_above()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.cmd.normal("O")
  vim.cmd.normal("j")
  vim.cmd.normal("0")
  vim.cmd.normal(tostring(col) .. "l")
end
vim.keymap.set("n", "<leader>O", insert_empty_line_above)

-- insert empty line above and return to original cursor position
function insert_empty_line_below()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.cmd.normal("o")
  vim.cmd.normal("k")
  vim.cmd.normal("0")
  vim.cmd.normal(tostring(col) .. "l")
end
vim.keymap.set("n", "<leader>o", insert_empty_line_below)


-- toggle relativenumber
vim.g.current_relativenumber = vim.opt.relativenumber
function toggle_relative_line_number()
  if vim.g.current_relativenumber then
    vim.opt.relativenumber = false
    vim.g.current_relativenumber = false
  else
    vim.opt.relativenumber = true
    vim.g.current_relativenumber = true
  end
end
-- toggle line numbers between relative and absolute
vim.keymap.set("n", "<leader>1", toggle_relative_line_number)


-- bufferline
-- go to selected buffer (selection options will appear in bufferline)
vim.keymap.set("n", "<leader>gb", "<Cmd>BufferLinePick<CR>")

-- delete selected buffer (selection options will appear in bufferline)
vim.keymap.set("n", "<leader>db", "<Cmd>BufferLinePickClose<CR>")

-- open new buffer
vim.keymap.set("n", "<leader>be", "<Cmd>enew<CR>")

-- close current buffer *without* closing current window
-- this prevents nvim-tree (if it's open) from being only window
vim.keymap.set("n", "<leader>bd", "<Cmd>bprevious<bar>split<bar>bnext<bar>bdelete<CR>")


-- cycle to next buffer
vim.keymap.set("n", "<leader>bn", "<Cmd>bn<CR>")

-- cycle to previous buffer
vim.keymap.set("n", "<leader>bp", "<Cmd>bp<CR>")


-- git-worktree
-- open git worktree menu
vim.keymap.set("n", "<leader>gw", "<Cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")

-- create new git worktree
vim.keymap.set("n", "<leader>cgw", "<Cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>")


-- lsp diagnostics navigations
vim.keymap.set("n", "<leader>dj", "<Cmd>lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "<leader>dk", "<Cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "<leader>dd", "<Cmd>ToggleDiag<CR>")


-- markdown-preview
-- toggle markdown preview (opens markdown preview in default browser)
vim.keymap.set("n", "<leader>md", "<Cmd>MarkdownPreviewToggle<CR>")


-- neovim-tree
-- "W" collapses all directories
vim.keymap.set("n", "<A-.>", "<Cmd>NvimTreeToggle<CR>") -- toggle neovim-tree
vim.keymap.set("n", "<A- >", "<Cmd>NvimTreeFindFile<CR>") -- find file in neovim-tree


-- copilot
function toggle_copilot()
  local cmp = require("cmp")
  local sources = cmp.get_config().sources
  local copilot_source_index = -1
  for i = #sources, 1, -1 do
    if sources[i].name == "copilot" then
      copilot_source_index = i
    end
  end
  if copilot_source_index == -1 then
    table.insert(sources, { name = "copilot" })
  else
    table.remove(sources, copilot_source_index)
  end
  cmp.setup.buffer({ sources = sources })
end

-- toggle Copilot
vim.keymap.set("n", "<leader>cp", toggle_copilot)

-- cycle window focus
vim.keymap.set("n", "<A-,>", "<C-W><C-W>")

-- LuaSnip shortcuts -- for latex files only
function luasnip_jump_if_jumpable()
  -- if not vim.bo.filetype == "tex" then
  --   return "jk"
  -- end
  local ls = require("luasnip")
  if ls.jumpable(1) then
    ls.jump(1)
  else
    return "jk"
  end
end
vim.keymap.set("i", "jk", luasnip_jump_if_jumpable, {expr=true})


-- nvim-spectre
-- open nvim-spectre (recursive find and replace)
vim.keymap.set("n", "<leader>s", "<Cmd>lua require('spectre').open()<CR>")


-- telescope
-- open telescope
vim.keymap.set("n", "<leader>T", "<Cmd>Telescope<CR>")

-- open diagnostics
vim.keymap.set("n", "<leader>fd", "<Cmd>Telescope diagnostics<CR>")

-- open fuzzyfinder (search for files)
vim.keymap.set("n", "<leader>ff", "<Cmd>Telescope find_files<CR>")

-- open live grep (search for content in files)
vim.keymap.set("n", "<leader>fg", "<Cmd>Telescope live_grep<CR>")

-- open fuzzyfinder limited in scope to open buffers
vim.keymap.set("n", "<leader>fb", "<Cmd>Telescope buffers<CR>")

-- open fuzzy finder to preview help options
vim.keymap.set("n", "<leader>fh", "<Cmd>Telescope help_tags<CR>")


-- treesitter
-- "za" toggles collapse on current expression
-- "zR" opens all expressions
-- "zM" collapses all expressions
-- "zr" opens one level of expressions from all open expressions
-- "zm" collapses one level of expressions from all open expressions

-- Using ufo provider need remap `zR` and `zM`
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)


-- twilight
vim.keymap.set("n", "<leader>tw", "<Cmd>Twilight<CR>")


-- vimtex
vim.keymap.set("n", "<leader>c", "<Cmd>VimtexCompile<CR>")


-- zenmode
vim.g.were_lsp_diagnostics_on_prior_to_zen_mode = true
function configure_zen_diagnostics()
  vim.cmd("Twilight")
  local tld = require("toggle_lsp_diagnostics")
  if require("zen-mode").is_open() then
    if vim.g.were_lsp_diagnostics_on_prior_to_zen_mode then
      tld.turn_on_diagnostics()
      vim.opt.cmdheight = 1
      require("lualine").hide({unhide = true})
    end
  else
    vim.g.were_lsp_diagnostics_on_prior_to_zen_mode = tld.are_diagnostics_on()
    tld.turn_off_diagnostics()
    vim.opt.cmdheight = 1
    require("lualine").hide()
  end
  vim.cmd("ZenMode")
end

-- toggle zen mode
vim.keymap.set("n", "<leader>zz", configure_zen_diagnostics)

-- --------------------------------------------- --

-- Autocommands
-- --------------------------------------------- --

-- autoformat on save for these file types
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 1000 })
  end,
  group = vim.api.nvim_create_augroup("Format", {}),
})

-- prevent status line from changing when switching focus to neovim tree
vim.api.nvim_create_autocmd({"BufEnter","BufWinEnter","WinEnter","CmdwinEnter"}, {
  pattern = "*",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == "NvimTree" then
      vim.opt.laststatus = 2
    else
      vim.opt.laststatus = 3
    end
  end,
})
-- --------------------------------------------- --
