local options = {
  encoding = "utf-8",
  hidden = true,
  clipboard = "unnamedplus",
  termguicolors = true, -- required for bufferline

  linespace = 8,
  scrolloff = 2,
  sidescrolloff = 8,
  splitbelow = true,
  splitright = true,
  backspace = { "indent", "eol", "start" },
  expandtab = true,
  shiftwidth = 2, -- Size of an indent
  tabstop = 2, -- Number of spaces tabs count for

  wildmode = "longest:full,full",
  wrap = false,
  list = true, -- Show some invisible characters
  listchars = { tab = " ", trail = "·" },

  undofile = true,
  undolevels = 10000,

  backup = true,
  backupdir = "/tmp/,/private/tmp",
  directory = "/tmp/,/private/tmp",

  timeout = true,
  timeoutlen = 300,
  ttimeoutlen = 200,

  mouse = "a",
  startofline = false,
  number = true,
  relativenumber = true,
  signcolumn = "auto",

  shortmess = "filnxtToOFc",
  completeopt = "menu,menuone,noselect",

  updatetime = 2000,
  redrawtime = 5000,

  cmdheight = 2,

  -- vim.o.lazyredraw = true,

  spelllang = { "en_us" },

  -- opt.spellfile = vim.fn.stdpath("config") .. "/spell"
  -- opt.spellsuggest = 10

  incsearch = true,
  ignorecase = true,
  smartcase = true,
  hlsearch = true,

  background = "dark",

  filetype = "on",
  -- opt.plugin = "on"
  -- opt.indent = "on"
  syntax = "on",

  -- Cursor settings https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
  -- let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  -- let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  -- let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

  cursorline = false,
  cursorcolumn = false,

  smartindent = false, -- Insert indents automatically
  cindent = true, -- https://vim.fandom.com/wiki/Restoring_indent_after_typing_hash
  guicursor = "n-v-c-sm:block-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,r-cr-o:hor20",


  laststatus = 3,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set indentkeys-=0#") -- https://vim.fandom.com/wiki/Restoring_indent_after_typing_hash

vim.cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = true}")

-- this lets you do `gf` (go to file) on e.g.: "plugins/monokai.lua"
vim.cmd("set path+=~/.config/nvim/lua/plugins/")

vim.g.markdown_fenced_languages = { "html", "javascript", "typescript", "css", "scss", "lua", "vim" }

-- https://dockyard.com/blog/2018/06/01/simple-vim-session-management-part-1
-- this is a custom variable to be used with a custom command defined in the linked article
vim.g.session_dir = "~/.config/nvim/sessions/"

-- opt.foldenable = false
-- opt.foldmethod = "indent"
-- opt.hlsearch = true -- Highlight found searches
-- opt.ignorecase = true -- Ignore case
-- opt.inccommand = "split" -- Get a preview of replacements
-- opt.incsearch = true -- Shows the match while typing
-- opt.joinspaces = false -- No double spaces with join
-- opt.linebreak = true -- Stop words being broken on wrap
-- opt.shiftround = true -- Round indent
-- opt.signcolumn = "yes:1" -- always show signcolumns
-- opt.smartcase = true -- Do not ignore case with capitals
-- vim.o.whichwrap = vim.o.whichwrap .. "<,>" -- Wrap movement between lines in edit mode with arrows
-- opt.wrap = true
-- -- opt.cc = "80"
--
--

vim.opt.shortmess:append("c")

