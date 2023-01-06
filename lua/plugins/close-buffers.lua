local map = vim.api.nvim_set_keymap

map("n", "<C-Q>", ":Bdelete menu<CR>", KeymapOptions("BDelete menu"))
map("n", "<Tab>qo", ":Bdelete other<CR>", KeymapOptions("Close all other buffers"))
