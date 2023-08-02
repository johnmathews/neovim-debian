local is_mac = vim.fn.has "macunix" == 1
if is_mac then
  local home_dir = "/Users/john"
else
  local home_dir = "/home/john"
end

vim.cmd("let g:python3_host_prog = expand('~/.pyenv/versions/3.10.0/envs/nvim/bin/python3')")
vim.cmd("let g:node_host_prog = expand('~/.nvm/versions/node/v18.16.0/bin/node')")
-- vim.g.node_host_prog ='~/.nvm/versions/node/v18.16.0/bin/node' 

function KeymapOptions(description)
  description = description or "no description"
  return {
    noremap = true,
    silent = true,
    desc = description,
  }
end

-- for lazy
vim.api.nvim_set_keymap("n", "<Space>", "<Nop>", KeymapOptions("unmap space so it can be the Leader Key"))
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("options")
require("plugins")

require("functions")
require("mappings")
require("autocmd")

vim.cmd("colorscheme workaround")

-- load custom snippets. dont remove this.
require("luasnip.loaders.from_lua").load({ paths = "./lua/snippets" })
