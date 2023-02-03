require("harpoon").setup()

local map = vim.api.nvim_set_keymap
map("n", "ga", ":lua require('harpoon.mark').add_file()<CR>:echom 'added to Harpoon'<CR>", KeymapOptions("Harpoon Add"))
map("n", "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", KeymapOptions("Harpoon Toggle"))
map("n", "gn", ":lua require('harpoon.ui').nav_next()<CR>", KeymapOptions("Harpoon Next"))
map("n", "gp", ":lua require('harpoon.ui').nav_prev()<CR>", KeymapOptions("Harpooon Previous"))
map("n", "<Tab>1", ":lua require('harpoon.ui').nav_file(1)<CR>", KeymapOptions("Harpoon buffer"))
map("n", "<Tab>2", ":lua require('harpoon.ui').nav_file(2)<CR>", KeymapOptions("Harpoon buffer"))
map("n", "<Tab>3", ":lua require('harpoon.ui').nav_file(3)<CR>", KeymapOptions("Harpoon buffer"))
map("n", "<Tab>4", ":lua require('harpoon.ui').nav_file(4)<CR>", KeymapOptions("Harpoon buffer"))
