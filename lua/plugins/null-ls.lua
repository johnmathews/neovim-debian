local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  print("null-ls not found")
  return
end

null_ls.setup({
  debug = false,
  sources = {

    -- XML
    null_ls.builtins.formatting.xmllint,
    null_ls.builtins.formatting.tidy.with({
      filetypes = { "xml" },
      extra_args = { "--quiet", "--show-warnings", "--show-errors", "--show-info" },
    }),
    null_ls.builtins.diagnostics.tidy.with({
      filetypes = { "xml" },
      extra_args = { "--quiet", "--show-warnings", "--show-errors", "--show-info" },
    }),

    --  Prettier formatting works on Markdown, JavaScript, TypeScript, JSX,
    -- =======
    null_ls.builtins.formatting.prettier.with({
      extra_args = { "--prose-wrap", "always" },
    }),

    -- ESLint https://github.com/mantoni/eslint_d.js
    -- this might not be necessary in addition to prettier
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.eslint_d,

    -- PYTHON
    -- ======
    -- ruff and ruff-lsp is installed using mason
    null_ls.builtins.formatting.black -- use pyproject.toml for modifications
  },
})
