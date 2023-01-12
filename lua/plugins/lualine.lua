local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local function Current_col()
  ---@diagnostic disable-next-line: deprecated
  table.unpack = table.unpack or unpack -- 5.1 compatibility
  local _, column = table.unpack(vim.api.nvim_win_get_cursor(0))
  return "c" .. column + 1
end

function Row_max_row()
  ---@diagnostic disable-next-line: deprecated
  table.unpack = table.unpack or unpack -- 5.1 compatibility
  local row, _ = table.unpack(vim.api.nvim_win_get_cursor(0))
  local max_row = vim.api.nvim_buf_line_count(0)
  print("*** row .. " / " .. max_row = ", row .. "/" .. max_row)
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
    component_separators = { left = "", right = "" }, -- 
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "toggleterm" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { progress, require('auto-session-library').current_session_name, "progress", Row_max_row, Current_col,
      "mode" },
    -- lualine_a = { progress, '%{ObsessionStatus("$", "!$")}', "progress", Row_max_row, Current_col, "mode" },
    lualine_b = { { "branch", padding = { left = 3, right = 1 } }, { "diff", padding = { left = 1, right = 3 } } },
    lualine_c = { { show_filepath, padding = { right = 0 }, color = { fg = "#A9DC76" } },
      { show_filename, color = { fg = "#FF647F" }, padding = { left = 0, right = 2 },
        component_separators = { left = "", right = "" } }, { "diagnostics", padding = { left = 2, right = 2 } } },
    lualine_x = { "lsp_progress", "encoding", "fileformat", "filetype" },
    lualine_y = {},
    -- https://www.reddit.com/r/neovim/comments/q2s3t1/how_to_get_current_filename_relative_to_project/
    -- https://stackoverflow.com/questions/4525261/getting-relative-paths-in-vim
    lualine_z = {},
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
