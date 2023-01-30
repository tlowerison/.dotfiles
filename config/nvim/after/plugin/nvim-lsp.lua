local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.gopls.setup({
	cmd = {"gopls"},
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
	-- for postfix snippets and analyzers
	capabilities = capabilities,
})

lspconfig.terraformls.setup({})
lspconfig.tflint.setup({})
lspconfig.texlab.setup({
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
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
lspconfig.tsserver.setup({})

