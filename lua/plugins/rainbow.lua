-- colors are in the monokai config file

require("nvim-treesitter.configs").setup {
  highlight = {},
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  }
}
