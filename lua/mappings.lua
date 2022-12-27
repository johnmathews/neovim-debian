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
map("i", "jk", "<ESC>", default_options)
--jump back one word
map("i", "<C-h>", "<C-o>b", default_options)
-- delete the word infront of the cursor
map("i", "<C-e>", "<C-o>de", default_options)
-- try to make each word an undo step
-- map("i", "<SPACE>", "<C-o>u<SPACE>", default_options)

--Remap space as leader key
map("n", "<Space>", "<Nop>", default_options)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map("n", "<leader>ve", ":edit $MYVIMRC<CR>", default_options)
map("n", "<leader>vf", ":edit ~/.config/nvim/ftplugin/<C-R>=&filetype<CR>.vim<CR>", default_options)
map("n", "<leader>vr", ":source $MYVIMRC<CR>|:autocmd User VimReload<CR>", default_options)

-- These commands will sort buffers by directory, language, or a custom criteria
map("n", "be", ":BufferLineSortByExtension<CR>", default_options)
map("n", "bd", ":BufferLineSortByDirectory<CR>", default_options)

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

map("n", "<leader>lw", ":set nowrap!<CR>", default_options)
map("n", "<leader>ln", ":set relativenumber!<CR>", default_options)
map("n", "<leader>ss", ":setlocal spell!<CR>", default_options)

map("n", "o", "o<ESC>", default_options)
map("n", "O", "O<ESC>", default_options)

map("n", ";", ":", { noremap = true, silent = false })
map("n", ":", ";", { noremap = true, silent = false })
map("v", ";", ":", { noremap = true, silent = false })
map("v", ":", ";", { noremap = true, silent = false })

map("n", "<Tab>ww", ":wa<CR>", default_options)
--map("n", "<Tab>qq", ":FloatermKill!<CR><BAR>:qa<CR>", default_options)
map("n", "<Tab>qq", ":qa<CR>", default_options)

vim.api.nvim_create_user_command('BufOnly', '%bdelete|edit #|normal `"', {})
map("n", "<Tab>qo", ":BufOnly<CR>", default_options) -- close other buffers

map("n", "qq", ":bn|bd #<CR>", default_options)
-- map("n", "qq", ":b#|bd#<CR>", default_options) -- this doesnt work right. reopens a closed buffer
map("n", "<leader>Q", ":bufdo bdelete<CR>", default_options)
map("n", "gf", ":edit <cfile><CR>", default_options)

-- query which color - what and which kind of syntax is this color? - wc
-- ghl. highlight group
map("n", "wc",
  ":echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<' . synIDattr(synID(line('.'),col('.'),0),'name') .'> lo<' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'<CR>"
  ,
  default_options
)

-- TREESITTER
map("n", "<leader>ts", ":TSPlaygroundToggle<CR>", default_options)
map("n", "<leader>tc", ":TSHighlightCapturesUnderCursor<CR>", default_options)

-- open the current file in the default app
-- gx is mapped to open a url using the open-browser plugin
map("n", "<leader>x", ":!xdg-open %<CR><CR>", default_options)

-- Split navigations
map("n", "<C-H>", "<C-W><C-H>", default_options)
map("n", "<C-J>", "<C-W><C-J>", default_options)
map("n", "<C-K>", "<C-W><C-K>", default_options)
map("n", "<C-L>", "<C-W><C-L>", default_options)

-- FUNCTIONS
map("n", "cc", ":call ToggleQuickFix()<CR>", default_options)
-- vim.cmd([[ nmap cc <Plug>(qf_qf_toggle)]])

-- Jump List
map("n", "<C-p>", "<C-i>", default_options)

-- Luasnip
local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.choice_active() then
 ls.change_choice(-1)
 end
end)

