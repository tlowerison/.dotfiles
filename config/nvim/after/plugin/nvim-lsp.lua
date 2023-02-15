local lsp_status = require("lsp-status")
local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()

local function on_attach(client, buffer)
  -- This callback is called when the LSP is atttached/enabled for this buffer
  -- we could set keymaps related to LSP, etc here.
  -- Code navigation and shortcuts
  vim.keymap.set("n", "gd", vim.lsp.buf.definition)
  vim.keymap.set("n", "ga", vim.lsp.buf.code_action)
  
  vim.keymap.set("n", "K", vim.lsp.buf.hover)
  vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition)
  vim.keymap.set("n", "gD", vim.lsp.buf.implementation)
  vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help)
  vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition)
  vim.keymap.set("n", "gr", vim.lsp.buf.references)
  vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol)
  vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol)
  
  -- lsp_status.on_attach(client, buffer)
end

lspconfig.gopls.setup({
	cmd = { "gopls" },
  on_attach = on_attach,
	capabilities = capabilities,
	settings = {
	  gopls = {
	    experimentalPostfixCompletions = true,
	    analyses = {
	      unusedparams = true,
	      shadow = true,
	   },
	   staticcheck = true,
	  },
	},
})

lspconfig.terraformls.setup({
  on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.tflint.setup({
  on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.texlab.setup({
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
  on_attach = on_attach,
	capabilities = capabilities,
  settings = {
    texlab = {
      auxDirectory = ".",
      bibtexFormatter = "texlab",
      build = {
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        executable = "latexmk",
        forwardSearchAfter = false,
        onSave = false,
      },
      chktex = {
        onEdit = false,
        onOpenAndSave = false,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = {
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = { "%l", "%p", "%f" },
      },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = false,
      },
    },
  },
})

lspconfig.tsserver.setup({
  on_attach = on_attach,
	capabilities = capabilities,
})

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
      only_current_line = false,
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
    capabilities = capabilities,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        checkOnSave = {
          enable = true,
          command = "check",
          extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    vim.lsp.start({
      name = "bash-language-server",
      cmd = { "bash-language-server", "start" },
    })
  end,
})
