-- use this table to disable/enable filetypes
vim.g.copilot_filetypes = { xml = false }

-- since most are enabled by default you can turn them off
-- using this table and only enable for a few filetypes
-- vim.g.copilot_filetypes = { ["*"] = false, python = true }


local map = vim.api.nvim_set_keymap
local default_options = { noremap = true, silent = true }
local expr_options = { noremap = true, expr = true, silent = true }

map("i", "<Tab><Space>", ":edit $MYVIMRC<CR>", default_options)
vim.cmd[[imap <silent><script><expr> <Tab><Space> copilot#Accept("\<CR>")]]

vim.g.copilot_no_tab_map = true
-- vim.keymap.set.keymap("i", "<C-a>", ":copilot#Accept('\\<CR>')<CR>", { silent = true })

-- <C-]>                   Dismiss the current suggestion.
-- <Plug>(copilot-dismiss)
--
--                                                 *copilot-i_ALT-]*
-- <M-]>                   Cycle to the next suggestion, if one is available.
-- <Plug>(copilot-next)
--
--                                                 *copilot-i_ALT-[*
-- <M-[>                   Cycle to the previous suggestion.
-- <Plug>(copilot-previous)


