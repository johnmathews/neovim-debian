local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local function Current_col()
  local _, column = unpack(vim.api.nvim_win_get_cursor(0))
  return column + 1
end

local function Row_max_row()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local max_row = vim.api.nvim_buf_line_count(0)
  return row .. "/" .. max_row
end

local function show_filename()
  local filename = vim.fn.expand("%:t")
  return "/" .. filename
end

local function show_filepath()
  local parent = vim.fn.expand("%:h")
  return parent
end

-- progress function
local progress = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

lualine.setup({
  options = {
    icons_enabled = true,
    globalstatus = true, -- true for laststatus=3, false by default
    theme = "ayu_mirage",
    -- theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "toggleterm" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { progress, '%{ObsessionStatus("$", "!$")}', "progress", Row_max_row, Current_col, "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { show_filepath, padding={right=0}, color = { fg = "#A9DC76" } }, { show_filename, color = { fg = "#78DCE8" }, padding={left=0} } },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = {},
    lualine_z = {
      -- {
      --   "filename",
      --   file_status = true, -- Displays file status (readonly status, modified status)
      --   newfile_status = false, -- Display new file status (new file means no write after created)
      --   path = 1, -- 0: Just the filename
      --   -- 1: Relative path
      --   -- 2: Absolute path
      --   -- 3: Absolute path, with tilde as the home directory

      --   shorting_target = 40, -- Shortens path to leave 40 spaces in the window
      --   -- for other components. (terrible name, any suggestions?)
      --   symbols = {
      --     modified = "[+]", -- Text to show when the file is modified.
      --     readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
      --     unnamed = "[No Name]", -- Text to show for unnamed buffers.
      --     newfile = "[New]", -- Text to show for new created file before first writting
      --   },
      -- },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
