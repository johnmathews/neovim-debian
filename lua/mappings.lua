-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local map = vim.api.nvim_set_keymap
local default_options = { noremap = true, silent = true }
local expr_options = { noremap = true, expr = true, silent = true }

----- INSERT MODE ---------------
map("i", "jk", "<ESC>", KeymapOptions("enter Insert Mode"))
--jump back one word
map("i", "<C-h>", "<C-o>b", KeymapOptions("jump back one word"))
-- delete the word infront of the cursor
map("i", "<C-e>", "<C-o>de", KeymapOptions("delete the next word"))
-- try to make each word an undo step
-- map("i", "<SPACE>", "<C-o>u<SPACE>", default_options)

--Remap space as leader key
map("n", "<Space>", "<Nop>", KeymapOptions("unmap space so it can be the Leader Key"))
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map("n", "<leader>ve", ":edit $MYVIMRC<CR>", KeymapOptions("edit vimrc"))
map("n", "<leader>vf", ":edit ~/.config/nvim/ftplugin/<C-R>=&filetype<CR>.vim<CR>",
  KeymapOptions("edit ftplugin file for current buffers filetype"))
map("n", "<leader>vr", ":source $MYVIMRC<CR>|:autocmd User VimReload<CR>", KeymapOptions("reload vimrc file"))

-- Natural cursor movement over wrapped lines
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)

-- better indenting
-- map("v", "<", "<gv", default_options)
-- map("v", ">", ">gv", default_options)

-- paste over currently selected text without yanking it
map("v", "p", '"_dP', default_options)

-- Searching
-- map("n", "/", "`", { noremap = true, silent = false })
map("n", "`", "/", { noremap = true, silent = false })
map("n", "``", ": nohlsearch<CR>", default_options)
map("n", "*", "*``", default_options)

map("n", "<leader>tw", ":set nowrap!<CR>", KeymapOptions("toggle linewrap"))
map("n", "<leader>tn", ":set relativenumber!<CR>", KeymapOptions("toggle relative line numbers"))
map("n", "<leader>ts", ":setlocal spell!<CR>", KeymapOptions("toggle spell checker"))

map("n", "o", "o<ESC>", default_options)
map("n", "O", "O<ESC>", default_options)

map("n", ";", ":", { noremap = true, silent = false })
map("n", ":", ";", { noremap = true, silent = false })
map("v", ";", ":", { noremap = true, silent = false })
map("v", ":", ";", { noremap = true, silent = false })

map("n", "<Tab>ww", ":wa<CR>", KeymapOptions("Write all buffers"))
map("n", "<Tab>qq", ":qa<CR>", KeymapOptions("Quit all buffers"))

vim.api.nvim_create_user_command('BufOnly', '%bdelete|edit #|normal `"', {})
map("n", "<Tab>qo", ":BufOnly<CR>", KeymapOptions("Close other buffers"))

map("n", "qq", ":bn|bd #<CR>", KeymapOptions("Quit buffer"))
map("n", "<leader>Q", ":bufdo bdelete<CR>", default_options)
map("n", "gf", ":edit <cfile><CR>", default_options)

-- query which color - what and which kind of syntax is this color? - wc
-- ghl. highlight group
map("n", "wc",
  ":echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<' . synIDattr(synID(line('.'),col('.'),0),'name') .'> lo<' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'<CR>"
  ,
  KeymapOptions("Get current highlight group")
)

-- TREESITTER
map("n", "<leader>tp", ":TSPlaygroundToggle<CR>", KeymapOptions("Treesitter Playground"))
map("n", "<leader>tc", ":TSHighlightCapturesUnderCursor<CR>", KeymapOptions("Treesitter item under cursor"))

-- open the current file in the default app
-- gx is mapped to open a url using the open-browser plugin
map("n", "<leader>x", ":!xdg-open %<CR><CR>", KeymapOptions("Open current file in default app"))

-- Split navigations
map("n", "<C-H>", "<C-W><C-H>", default_options)
map("n", "<C-J>", "<C-W><C-J>", default_options)
map("n", "<C-K>", "<C-W><C-K>", default_options)
map("n", "<C-L>", "<C-W><C-L>", default_options)

-- FUNCTIONS
map("n", "gq", ":call ToggleQuickFix()<CR>", KeymapOptions("toggle quickfix window"))

-- Jump List
map("n", "<C-p>", "<C-i>", default_options)

-- Luasnip
local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, KeymapOptions("LuaSnip choice node next"))

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end 
end, KeymapOptions("LuaSnip choice node previous"))
