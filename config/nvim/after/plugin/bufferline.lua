local should_display_empty_buffers = true
local bufferline = require("bufferline")

bufferline.setup({
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
  options = {
    offsets = {
      {
        filetype = "NvimTree",
        text = "",
        -- highlight = "Directory",
        separator = " ", -- use a "true" to enable the default, or set your own character
        text_align = "center",
      },
    },
    color_icons = false,
    show_buffer_icons = false,
    always_show_bufferline = true,
    custom_filter = function(bufnr)
      if is_empty_buffer(bufnr) then
        return should_display_empty_buffers
      end
      return true
    end,
  }
})

function remove_empty_buffers()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if is_empty_buffer(bufnr) then
      vim.cmd("bd " .. bufnr)
    end
  end
  should_display_empty_buffers = true
end

function is_empty_buffer(bufnr)
  return vim.api.nvim_buf_get_name(bufnr) == "" and vim.api.nvim_buf_line_count(bufnr) == 1
end

-- remove empty buffers when opening file buffer
-- creates smooth experience when opening a file from
-- nvim-tree and no other files are open
vim.api.nvim_create_autocmd("BufAdd", {
  group = vim.api.nvim_create_augroup("BufferlineRemoveNoNameBuffers", { clear = true }),
  pattern = "?*",
  callback = function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) then
        if is_empty_buffer(bufnr) then
          should_display_empty_buffers = false
        end
      end
    end
    vim.fn.timer_start(0, remove_empty_buffers)
  end,
})
