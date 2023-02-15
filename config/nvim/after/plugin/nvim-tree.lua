require("nvim-tree").setup({
  diagnostics = {
    enable = true,
    debounce_delay = 200,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
    severity = {
      min = vim.diagnostic.severity.ERROR,
      max = vim.diagnostic.severity.ERROR,
    },
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  renderer = {
    group_empty = true,
    icons = {
      git_placement = "after",
      show = {
        git = true,
        folder = true,
        file = false,
        folder_arrow = true,
      },
    },
  },
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    relativenumber = true,
  },
})
