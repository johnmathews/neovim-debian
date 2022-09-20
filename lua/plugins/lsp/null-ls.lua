local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	print("null-ls not found")
	return
end

-- SOURCES
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions
-- local hover = null_ls.builtins.hover
local completion = null_ls.builtins.completion

null_ls.setup({
	debug = false,
	sources = {
		-- general
		actions.refactoring,
    null_ls.builtins.code_actions.gitsigns,
		-- actions.gitsigns,
		completion.tags,
		-- completion.luasnip,
		-- completion.spell,
		-- hover.dictionary,

		-- python
		-- diagnostics.flake8.with({ extra_args = { "--max-line-length=120" } }),
		formatting.yapf.with({ extra_args = { "column_limit=120", "based_on_style=pep8" } }),
		formatting.isort,

		-- javascript
		-- prettier args are in either projects prettierrc or prettier plugin config file
		-- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote=false" } }),

    -- typescript
     diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    diagnostics.fish,

		-- lua
		formatting.stylua.with({
			extra_args = function(params)
				return params.options
					and params.options.tabsize
					and { "--indent-type", "Spaces" }
					and { "--indent-width", params.optimtns.tabsize }
			end,
		}),
	},
})
