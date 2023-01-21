local keymap = vim.keymap.set
local saga = require('lspsaga')

saga.setup({
  outline = {
    win_width = 40,
  }
})

-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "<leader>f", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, desc = "LSP finder" })
keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true, desc = "LspSaga code actions" })
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true, desc = "LspSaga rename" })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true, desc = "LspSaga peek definition" })
keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, desc = "LspSaga line diagnostics" })

-- Show cursor diagnostics
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true, desc = "LspSaga cursor diagnostics"})

-- Diagnostic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, desc = "LspSaga prev diagnostic"})
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, desc = "LspSaga next diagnostic"})
keymap("n", "[E", function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { silent = true, desc = "LspSaga prev error"})
keymap("n", "]E", function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { silent = true, desc = "LspSaga next error"})

-- Outline is buggy
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true, desc = "LspSaga outline" })

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, desc = "LspSaga documentation" })
