require("copilot").setup({
  panel = {
    enabled = true,
  },
  suggestion = {
    enabled = true,
    debounce = 200,
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = "node", -- Node.js version must be > 18.x
  server_opts_overrides = {},
})

require("copilot_cmp").setup()
