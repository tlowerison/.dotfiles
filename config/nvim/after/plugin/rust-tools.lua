
local function on_attach(client, buffer)
  -- This callback is called when the LSP is atttached/enabled for this buffer
  -- we could set keymaps related to LSP, etc here.
  -- Code navigation and shortcuts
  vim.keymap.set("n", "gd", vim.lsp.buf.definition)
  vim.keymap.set("n", "ga", vim.lsp.buf.code_action)
  
  -- vim.keymap.set("n", "K", vim.lsp.buf.hover)
  -- vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition)
  -- vim.keymap.set("n", "gD", vim.lsp.buf.implementation)
  -- vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help)
  -- vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition)
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references)
  -- vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol)
  -- vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol)
end

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
require("rust-tools").setup({
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      only_current_line = true,
      other_hints_prefix = "",
      parameter_hints_prefix = "",
      show_parameter_hints = false,
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        checkOnSave = {
          enable = false, -- workspaces are too big to run check on save
          command = "clippy",
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
})

local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 200 })
  end,
  group = format_sync_grp,
})
