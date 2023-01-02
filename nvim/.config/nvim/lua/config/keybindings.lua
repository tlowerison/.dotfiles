local Remap = require("config.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap

-- redo
nnoremap("U", "<C-r>")

-- relativenumber
relativenumber = vim.opt.relativenumber
function toggle_relative_line_number()
  if(relativenumber) then
    relativenumber = false
    vim.opt.relativenumber = false
  else
    relativenumber = true
    vim.opt.relativenumber = true
  end
end
nnoremap("<leader>1", "<Cmd>lua toggle_relative_line_number()<CR>") -- toggle line numbers between relative and absolute

-- bufferline
nnoremap("<leader>gb", "<Cmd>BufferLinePick<CR>")
nnoremap("<leader>gD", "<Cmd>BufferLinePickClose<CR>")
nnoremap("<leader>be", "<Cmd>enew<CR>") -- open new buffer
nnoremap("<leader>bd", "<Cmd>:bd<CR>")  -- close current buffer
nnoremap("<leader>bn", "<Cmd>:bn<CR>")  -- cycle to next buffer
nnoremap("<leader>bp", "<Cmd>:bp<CR>")  -- cycle to previous buffer

-- git-worktree
nnoremap("<leader>gw", "<Cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")
nnoremap("<leader>cgw", "<Cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>")

-- markdown-preview
nnoremap("<leader>md", "<Cmd>MarkdownPreviewToggle<CR>")

-- neovim-tree
-- "W" collapses all directories
nnoremap("<A-.>", "<Cmd>NvimTreeToggle<CR>") -- toggle neovim-tree
nnoremap("<A-,>", "<Cmd>NvimTreeFocus<CR>")  -- focus neovim-tree

-- nvim-spectre
nnoremap("<leader>s", "<Cmd>lua require('spectre').open()<CR>")

-- telescope
nnoremap("<leader>t", "<Cmd>Telescope<CR>")
nnoremap("<leader>ff", "<Cmd>Telescope find_files<CR>")
nnoremap("<leader>fg", "<Cmd>Telescope live_grep<CR>")
nnoremap("<leader>fb", "<Cmd>Telescope buffers<CR>")
nnoremap("<leader>fh", "<Cmd>Telescope help_tags<CR>")


-- treesitter
-- "za" toggles collapse on current expression
-- "zR" opens all expressions
-- "zM" collapses all expressions
-- "zr" opens one level of expressions from all open expressions
-- "zm" collapses one level of expressions from all open expressions

-- zenmode
nnoremap("<leader>zz", "<Cmd>ZenMode<CR>")
