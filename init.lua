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
require("mappings")
require("autocmd")

-- load custom snippets. dont remove this.
require("luasnip.loaders.from_lua").load({ paths = "./lua/snippets" })

-- this is just some stuff to make syntax highlighting work in .env files
-- Ensure the setup_env_syntax function is local to avoid polluting the global namespace
local function setup_env_syntax()
    vim.cmd [[
    syntax clear
    syntax match EnvComment "#.*" contains=@Spell
    syntax match EnvKey "^\s*\w\+" nextgroup=EnvSeparator
    syntax match EnvSeparator "=" contained nextgroup=EnvValue
    syntax match EnvValue "[\w@-]\+" contained

    highlight EnvComment ctermfg=Cyan guifg=Cyan
    highlight EnvKey ctermfg=White guifg=White
    highlight EnvSeparator ctermfg=Yellow guifg=Yellow
    highlight EnvValue ctermfg=Red guifg=Red
    ]]
end

-- Use vim.api.nvim_create_autocmd to set up the autocommand
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.env",
    callback = function()
        setup_env_syntax()
    end,
})

-- use the following to see what highlight group the text under the cursor is part of
-- :exe 'hi '.synIDattr(synstack(line('.'), col('.'))[-1], 'name')
