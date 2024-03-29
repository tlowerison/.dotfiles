-- uncomment the line below if you need to debug any language servers
-- you can watch logs using the command 'tail -f "$HOME/.local/state/nvim/lsp.log"'
-- vim.lsp.set_log_level('debug')

require("neoconf").setup({
  -- override any of the default settings here
})

local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

require("toggle_lsp_diagnostics").init()

local capabilities = vim.lsp.protocol.make_client_capabilities()

local function on_attach(_, bufnr)
  -- This callback is called when the LSP is atttached/enabled for this buffer
  -- we could set keymaps related to LSP, etc here.
  -- Code navigation and shortcuts
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = bufnr})
  vim.keymap.set("n", "ga", vim.lsp.buf.code_action, {buffer = bufnr})
  
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = bufnr})
  vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, {buffer = bufnr})
  vim.keymap.set("n", "gD", vim.lsp.buf.implementation, {buffer = bufnr})
  vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, {buffer = bufnr})
  vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, {buffer = bufnr})
  vim.keymap.set("n", "gr", vim.lsp.buf.references, {buffer = bufnr})
  vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, {buffer = bufnr})
  vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, {buffer = bufnr})
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({-- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = null_ls_augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = null_ls_augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
  sources = {
    null_ls.builtins.code_actions.shellcheck,

    null_ls.builtins.diagnostics.opacheck,
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.shellcheck,

    null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.prettierd.with({
      condition = function(utils)
        return utils.has_file({ ".prettierrc.yaml" })
      end,
    }),
    null_ls.builtins.formatting.rego,
    null_ls.builtins.formatting.rustywind,
    -- null_ls.builtins.formatting.shellharden, -- causes way more problems than is worth, just use shellcheck for diagnostics
    null_ls.builtins.formatting.stylua,
  },
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lspconfigs = {
  bashls = {
    cmd_env = { INCLUDE_ALL_WORKSPACE_SYMBOLS = "true" },
    on_attach = on_attach,
    capabilities = capabilities,
  },
  eslint = {
    settings = {
      packageManager = "yarn",
    },
    on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  },
  gopls = {
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
  },
  terraformls = {
    on_attach = on_attach,
	  capabilities = capabilities,
  },
  texlab = {
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
  },
  tflint = {
    on_attach = on_attach,
  	capabilities = capabilities,
  },
  tsserver = {
    on_attach = on_attach,
  	capabilities = capabilities,
  },
}

for server, config in pairs(lspconfigs) do
  lspconfig[server].setup(config)
end

-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local rust_tools = require("rust-tools")
rust_tools.setup({
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
        cargo = {
          features = "all",
        },
        checkOnSave = {
          enable = true,
          command = "check",
          extraArgs = { "--target-dir", "target/rust-analyzer" },
        },
        diagnostics = {
          disabled = {"inactive-code"},
        },
        procMacro = {
          enable = true,
        },
        server = {
          extraEnv = {
            ["RUSTUP_TOOLCHAIN"] = "stable",
          },
        },
      },
    },
  },
})
