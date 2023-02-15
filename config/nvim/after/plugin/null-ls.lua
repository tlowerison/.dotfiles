local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.shellcheck,

    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.buf,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.dotenv_linter,
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.opacheck,
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.sqlfluff.with({
      extra_args = { "--dialect", "postgres" },
    }),
    null_ls.builtins.diagnostics.tsc,

    null_ls.builtins.formatting.eslint,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.rego,
    null_ls.builtins.formatting.rustywind,
    null_ls.builtins.formatting.sqlformat,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.terraform_fmt,
  },
})
