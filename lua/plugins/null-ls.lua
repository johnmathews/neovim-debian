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

    -- PYTHON
    -- ======
    null_ls.builtins.diagnostics.flake8, -- style and code-quality checker
    null_ls.builtins.formatting.isort, -- import order
    null_ls.builtins.formatting.black, -- formatting
    null_ls.builtins.formatting.autoflake, -- remove unused imports
    -- null_ls.builtins.diagnostics.pylint.with({ --  static code analysis
    --   diagnostics_postprocess = function(diagnostic)
    --     diagnostic.code = diagnostic.message_id
    --   end,
    -- }),
  },
})
