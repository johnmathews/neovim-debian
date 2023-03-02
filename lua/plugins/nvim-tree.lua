-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local api_status_ok, nvim_tree_api = pcall(require, "nvim-tree.api")
if not api_status_ok then
  return
end

vim.api.nvim_set_keymap("n", "<Leader>n", ":NvimTreeFindFileToggle<cr>",
  { noremap = true, silent = true, desc = "open/close nvim-tree" })

vim.keymap.set("n", "zl", require("nvim-tree.api").marks.navigate.select,
  { noremap = true, silent = true, desc = "List nvim-tree bookmarks" })
vim.keymap.set("n", "zc", require("nvim-tree.api").marks.clear,
  { noremap = true, silent = true, desc = "Clear nvim-tree bookmarks" })

nvim_tree.setup {
  -- https://github.com/ahmedkhalf/project.nvim
  renderer = {
    highlight_opened_files = 'all',
    icons = {
      webdev_colors = true,
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      }
    },
  },
  respect_buf_cwd = true,
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_cwd = false,
  diagnostics = {
    enable = false,
    icons = {
      hint = "H", --""",
      info = "I", --""",
      warning = "W", --"",
      error = "E", --""",
    },
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  filters = {
    dotfiles = true,
    custom = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 50,
    hide_root_folder = false,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = "?",                  action = "toggle_help" },
        { key = "g?",                 action = "" },
        { key = { "l", "<CR>", "o" }, action = "edit" },
        { key = "h",                  action = "close_node" },
        { key = "v",                  action = "vsplit" },
        { key = "<C-v>",              action = "" },
        { key = "s",                  action = "split" },
        { key = "<C-x>",              action = "" },
        { key = "<C-d>",              action = "trash" },
        { key = "m",                  action = "toggle_mark" },
        { key = "D",                  action = "" },
        { key = "<Tab>",              action = "" },
        { key = "<C-e>",              action = "" },
      },
    },
    number = false,
    relativenumber = false,
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
}

local function open_nvim_tree()
  nvim_tree_api.tree.toggle({ focus = false, find_file = true, })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
