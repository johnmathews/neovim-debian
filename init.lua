vim.cmd("let g:python3_host_prog = expand('~/.pyenv/versions/3.10.0/envs/nvim/bin/python3')")


vim.cmd("let g:node_host_prog = expand('~/.nvm/versions/node/v17.9.0/bin/node')")

-- use nvim 0.7 experimental filetype detection. should give faster startup time
-- https://gpanders.com/blog/whats-new-in-neovim-0-7/
-- vim.cmd("let g:do_filetype_lua = 1")
-- vim.cmd("let g:did_load_filetypes = 0")

require("options")
require("plugins")
require("plugins.lsp")

require("functions")
require("mappings")
require("autocmd")

vim.cmd("colorscheme workaround")

-- load custom snippets. dont remove this.
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/luasnippets" })

local foo = 123
local bar = foo * 2
