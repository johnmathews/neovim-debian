vim.cmd("let g:python3_host_prog = expand('~/.pyenv/versions/3.10.0/envs/nvim/bin/python3')")
vim.cmd("let g:node_host_prog = expand('~/.nvm/versions/node/v17.9.0/bin/node')")


function KeymapOptions(description)
  description = description or "no description"
  return {
    noremap = true,
    silent = true,
    desc = description,
  }
end

require("options")
require("plugins")

require("functions")
require("mappings")
require("autocmd")

vim.cmd("colorscheme workaround")

-- load custom snippets. dont remove this.
-- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
require("luasnip.loaders.from_lua").load({ paths = "./lua/snippets" })
