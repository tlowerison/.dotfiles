require("ufo").setup({
  open_fold_hl_timeout = 150,
  close_fold_kinds_for_ft = {"imports", "comment"},
  preview = {
    win_config = {
      border = {"", "─", "", "", "", "─", "", ""},
      winhighlight = "Normal:Folded",
      winblend = 0
    },
    mappings = {
      scrollU = "<C-u>",
      scrollD = "<C-d>"
    }
  },
  provider_selector = function()
    return {"treesitter", "indent"}
  end
})

