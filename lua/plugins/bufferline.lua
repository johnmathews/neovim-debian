require('bufferline').setup {
  options = {
    offsets = {
      {
        filetype = "NvimTree",
        text = "",
        -- text = function()
        --   return vim.fn.getcwd()
        -- end,
        highlight = "Directory",
        text_align = "left"
      }
    },
    sort_by = 'directory'
  }
}

local map = vim.api.nvim_set_keymap
local default_options = { noremap = true, silent = true }

vim.cmd("set sessionoptions+=globals")

-- These commands will navigate through buffers in order regardless of which mode you are using
-- if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
map("n", "[b", ":BufferLineCyclePrev<CR>", default_options)
map("n", "]b", ":BufferLineCycleNext<CR>", default_options)

map("n", "<localleader>bp", ":BufferLineMovePrev<CR>", default_options)
map("n", "<localLeader>bn", ":BufferLineMoveNext<CR>", default_options)

-- view a buffer by typing the character that appears
map("n", "gb", ":BufferLinePick<CR>", default_options)

-- select a buffer by its visible position
-- do this with harpoon instead
-- map("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", default_options)
-- map("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", default_options)
-- map("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", default_options)
-- map("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", default_options)
-- map("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", default_options)
-- map("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", default_options)
-- map("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", default_options)
-- map("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", default_options)
-- map("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", default_options)
