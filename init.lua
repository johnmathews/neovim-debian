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
require("luasnip.loaders.from_lua").load({ paths = "./lua/snippets" })

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
-- local status_ok, nvim_tree = pcall(require, "nvim-tree")
-- if not status_ok then
--   return
-- else
--   local function open_nvim_tree()
--     nvim_tree.api.tree.open()
--   end
--   vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree() })
-- end
