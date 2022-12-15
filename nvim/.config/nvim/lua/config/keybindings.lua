local Remap = require("config.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap

nnoremap("<A-.>", "<Cmd>NvimTreeToggle<CR>")

nnoremap("<leader>ff", "<Cmd>Telescope find_files<CR>")
nnoremap("<leader>fg", "<Cmd>Telescope live_grep<CR>")
nnoremap("<leader>fb", "<Cmd>Telescope buffers<CR>")
nnoremap("<leader>fh", "<Cmd>Telescope help_tags<CR>")

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

-- toggle line numbers between relative and absolute
nnoremap("<leader>1", "<Cmd>lua toggle_relative_line_number()<CR>")

-- open new buffer
nnoremap("<leader>be", "<Cmd>enew<CR>")
-- close current buffer 
nnoremap("<leader>bd", "<Cmd>:bd<CR>")
-- cycle to next buffer
nnoremap("<leader>bn", "<Cmd>:bn<CR>")

-- cycle to previous buffer
nnoremap("<leader>bp", "<Cmd>:bp<CR>")

-- open most recently closed buffer: <C-i><C-o>

nnoremap("<leader>gb", "<Cmd>BufferLinePick<CR>")
nnoremap("<leader>gD", "<Cmd>BufferLinePickClose<CR>")

