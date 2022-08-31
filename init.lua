vim.cmd("let g:python3_host_prog = expand('~/.pyenv/versions/3.10.0/envs/nvim/bin/python3')")

-- use nvim 0.7 experimental filetype detection. should give faster startup time
-- https://gpanders.com/blog/whats-new-in-neovim-0-7/
vim.cmd("let g:do_filetype_lua = 1")
vim.cmd("let g:did_load_filetypes = 0")

require("options")
require("plugins.lsp")
require("plugins")

require("functions")
require("mappings")
require("autocmd")

-- sonokai, zephyr, monokai_pro
-- vim.cmd("colorscheme monokai_pro")
-- vim.cmd("colorscheme monokai_pro")
-- require('monokai').setup { palette = require('monokai').pro }


-- load custom snippets. dont remove this.
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/luasnippets"})

vim.cmd[[highlight CopilotSuggestion guifg=#555555 ctermfg=3]]

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

