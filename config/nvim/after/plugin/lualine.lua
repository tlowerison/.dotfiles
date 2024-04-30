require("lualine").setup({
  options = {
    theme = "catppuccin",
    icons_enabled = false,
    disabled_filetypes = {
      winbar = {
        'aerial',
        'NvimTree',
        'starter',
        'Trouble',
        'qf',
      },
      statusline = {
        'starter',
        'NvimTree',
      },
    },
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch"},
    lualine_c = {
      {
        "filename",
        file_status = false,
        newfile_status = false,
        path = 1,
      },
      "aerial",
    },
    -- lualine_y = {},
    -- lualine_z = {},
    lualine_x = { "diff" },
    lualine_y = {
      {
        "diagnostics",
        sources = {"nvim_lsp"},
        sections = {"error", "warn"},
        symbols = {error = "E", warn = "W", info = "I", hint = "H"},
        colored = true,
        update_in_insert = true,
        always_visible = false,
      },
      "progress"
    },
    lualine_z = {"location"}
  },
})
