require("bufferline").setup{
  options = {
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true -- use a "true" to enable the default, or set your own character
      }
    },
    color_icons = false,
    show_buffer_icons = false,
    show_buffer_default_icon = false,
    always_show_bufferline = false,
  }
}
