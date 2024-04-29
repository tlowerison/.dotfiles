require("neoconf").setup({
  -- override any of the default settings here
})

local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

-- require("toggle_lsp_diagnostics").init()

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function on_attach(client, bufnr)
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
end

null_ls.setup({-- you can reuse a shared lspconfig on_attach callback here
  on_attach,
  sources = {
    null_ls.builtins.code_actions.shellcheck,

    null_ls.builtins.diagnostics.opacheck,
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.shellcheck,

    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.jq,
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
  -- tsserver = {
  --   on_attach = on_attach,
  -- 	capabilities = capabilities,
  --   init_options = {
  --     preferences = {
  --       includeCompletionsForModuleExports = false
  --     },
  --   }
  -- },
  vtsls = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      typescript = {
        inlayHints = {
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
    },
  },
}

vim.lsp.commands["editor.action.showReferences"] = function(command, ctx)
  local locations = command.arguments[3]
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if locations and #locations > 0 then
    local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
    vim.fn.setloclist(0, {}, " ", { title = "References", items = items, context = ctx })
    vim.api.nvim_command("lopen")
  end
end

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

-- local path_sep = package.config:sub(1, 1)
-- 
-- local function trim_sep(path)
--   return path:gsub(path_sep .. "$", "")
-- end
-- 
-- local function uri_from_path(path)
--   return vim.uri_from_fname(trim_sep(path))
-- end
-- 
-- local function is_sub_path(path, folder)
--   path = trim_sep(path)
--   folder = trim_sep(folder)
--   if path == folder then
--     return true
--   else
--     return path:sub(1, #folder + 1) == folder .. path_sep
--   end
-- end
-- 
-- local function check_folders_contains(folders, path)
--   for _, folder in pairs(folders) do
--     if is_sub_path(path, folder.name) then
--       return true
--     end
--   end
--   return false
-- end
-- 
-- local function match_file_operation_filter(filter, name, type)
--   if filter.scheme and filter.scheme ~= "file" then
--     -- we do not support uri scheme other than file
--     return false
--   end
--   local pattern = filter.pattern
--   local matches = pattern.matches
-- 
--   if type ~= matches then
--     return false
--   end
-- 
--   local regex_str = vim.fn.glob2regpat(pattern.glob)
--   if vim.tbl_get(pattern, "options", "ignoreCase") then
--     regex_str = "\\c" .. regex_str
--   end
--   return vim.regex(regex_str):match_str(name) ~= nil
-- end
-- 
-- local api = require("nvim-tree.api")
-- api.events.subscribe(api.events.Event.NodeRenamed, function(data)
--   local stat = vim.loop.fs_stat(data.new_name)
--   if not stat then
--     return
--   end
--   local type = ({ file = "file", directory = "folder" })[stat.type]
--   local clients = vim.lsp.get_active_clients({})
--   for _, client in ipairs(clients) do
--     if check_folders_contains(client.workspace_folders, data.old_name) then
--       local filters = vim.tbl_get(client.server_capabilities, "workspace", "fileOperations", "didRename", "filters")
--         or {}
--       for _, filter in pairs(filters) do
--         if
--           match_file_operation_filter(filter, data.old_name, type)
--           and match_file_operation_filter(filter, data.new_name, type)
--         then
--           client.notify(
--             "workspace/didRenameFiles",
--             { files = { { oldUri = uri_from_path(data.old_name), newUri = uri_from_path(data.new_name) } } }
--           )
--         end
--       end
--     end
--   end
-- end)
