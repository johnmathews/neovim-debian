require("harpoon").setup({
    menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
    }
})


local map = vim.api.nvim_set_keymap
local default_options = { noremap = true, silent = true }

map("n", "ga", ":lua require('harpoon.mark').add_file()<CR>:echom 'added to Harpoon'<CR>", default_options)
map("n", "gh", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", default_options)
map("n", "gn", ":lua require('harpoon.ui').nav_next()<CR>", default_options)
map("n", "gp", ":lua require('harpoon.ui').nav_prev()<CR>", default_options)
map("n", "<Tab>1", ":lua require('harpoon.ui').nav_file(1)<CR>", KeymapOptions("Harpoon buffer"))
map("n", "<Tab>2", ":lua require('harpoon.ui').nav_file(2)<CR>", KeymapOptions("Harpoon buffer"))
map("n", "<Tab>3", ":lua require('harpoon.ui').nav_file(3)<CR>", KeymapOptions("Harpoon buffer"))
map("n", "<Tab>4", ":lua require('harpoon.ui').nav_file(4)<CR>", KeymapOptions("Harpoon buffer"))

