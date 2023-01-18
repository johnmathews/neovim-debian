local keymap = vim.keymap.set
local saga = require('lspsaga')

saga.setup({
  symbol_in_winbar = {
    enable = true,
    separator = ' ',
    hide_keyword = true,
    show_file = true,
    folder_level = 2,
  },
  ui = {
    -- currently only round theme
    theme = 'round',
    -- border type can be single,double,rounded,solid,shadow.
    border = 'solid',
    winblend = 0,
    expand = '',
    collaspe = '',
    preview = ' ',
    code_action = '💡',
    diagnostic = '🐞',
    incoming = ' ',
    outgoing = ' ',
    colors = {
      --float window normal bakcground color
      normal_bg = '#1d1536',
      --title background color
      title_bg = '#afd700',
      red = '#e95678',
      magenta = '#b33076',
      orange = '#FF8700',
      yellow = '#f7bb3b',
      green = '#afd700',
      cyan = '#36d0e0',
      blue = '#61afef',
      purple = '#CBA6F7',
      white = '#d1d4cf',
      black = '#1c1c19',
    },
    kind = {},
  },
  move_in_saga = { prev = '<C-p>', next = '<C-n>' },
  preview = {
    lines_above = 2,
    lines_below = 10,
  },
  scroll_preview = {
    scroll_down = '<C-f>',
    scroll_up = '<C-b>',
  },
  code_action_icon = "💡",
  code_action_num_shortcut = true,
  lightbulb = {
    enable = true,
    enable_in_insert = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  code_action = {
    num_shortcut = true,
    keys = {
      quit = 'q',
      exec = '<CR>',
    },
  },
  diagnostic = {
    twice_into = false,
    show_code_action = true,
    show_source = true,
    keys = {
      exec_action = 'o',
      quit = 'q',
    },
  },
  finder = {
    edit = { 'o', '<CR>' },
    vsplit = 's',
    split = 'i',
    tabe = 't',
    quit = { 'q', '<ESC>' },
  },
  finder_request_timeout = 2500,
  definition = {
    edit = '<C-c>o',
    vsplit = '<C-c>v',
    split = '<C-c>i',
    tabe = '<C-c>t',
    quit = 'q',
    close = '<Esc>',
  },
  rename = {
    quit = '<C-c>',
    exec = '<CR>',
    mark = 'x',
    confirm = '<CR>',
    in_select = true,
    whole_project = true,
  },
  outline = {
    win_position = 'left',
    win_with = '',
    win_width = 50,
    show_detail = true,
    auto_preview = true,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
    keys = {
      jump = 'o',
      expand_collaspe = 'i',
      quit = 'q',
    },
  },
  callhierarchy = {
    show_detail = false,
    keys = {
      edit = 'e',
      vsplit = 's',
      split = 'i',
      tabe = 't',
      jump = 'o',
      quit = 'q',
      expand_collaspe = 'u',
    },
  },
})

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "<leader>f", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, desc = "LSP finder" })
keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostics
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Diagnostic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Only jump to error
keymap("n", "[E", function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
  { silent = true })
keymap("n", "]E", function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
  { silent = true })

-- Outline is buggy
-- keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- Float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
-- if you want to pass some cli command into a terminal you can do it like this
-- open lazygit in lspsaga float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
-- close floaterm
keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
