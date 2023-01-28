require('leap').add_default_mappings()

-- see the FAQ
vim.keymap.del({ 'x', 'o' }, 'x')
vim.keymap.del({ 'x', 'o' }, 'X')
