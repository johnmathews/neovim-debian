local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  print("null-ls not found")
  return
end

null_ls.setup({
  debug = false,
  sources = {

    -- GENERAL
    -- =======
    -- null_ls.builtins.code_actions.gitsigns,
    -- null_ls.builtins.completion.tags,

    --  Markdown, JavaScript, TypeScript, JSX,
    -- =======
    null_ls.builtins.formatting.prettier.with({
        extra_args = { "--prose-wrap", "always" },
    }),

    -- PYTHON
    -- ======
    null_ls.builtins.formatting.isort, -- import order
    null_ls.builtins.formatting.autoflake, -- remove unused imports
    null_ls.builtins.formatting.black, -- formatting
  },
})
