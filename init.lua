-- macOS or Unix 
local is_mac = vim.fn.has "macunix" == 1
if is_mac then
  local home_dir = "/Users/john"
else
  local home_dir = "/home/john"
end

vim.cmd("let g:python3_host_prog = expand('~/.pyenv/versions/3.10.12/envs/nvim/bin/python3')")
vim.cmd("let g:node_host_prog = expand('~/.nvm/versions/node/v18.16.0/bin/node')")

-- convenience function for adding keybind details to whichkey from a plugins config 
function KeymapOptions(description)
  description = description or "no description"
  return {
    noremap = true,
    silent = true,
    desc = description,
  }
end

vim.api.nvim_set_keymap("n", "<Space>", "<Nop>", KeymapOptions("unmap space so it can be the Leader Key"))
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


require("options")
require("plugins")

require("functions")
-- require("luaFunctions")
require("mappings")
require("autocmd")

-- load custom snippets. dont remove this.
require("luasnip.loaders.from_lua").load({ paths = "./lua/snippets" })

-- use the following to see what highlight group the text under the cursor is part of
-- :exe 'hi '.synIDattr(synstack(line('.'), col('.'))[-1], 'name')

-- can this be deleted now? 17 sep 2023
-- vim.cmd("colorscheme habamax")
-- vim.cmd("colorscheme workaround")

-- keep at end
-- vim.cmd("colorscheme monokai")
-- vim.cmd.colorscheme "one_monokai"
