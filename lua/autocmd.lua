vim.api.nvim_exec([[
  augroup foo
    au!
    autocmd BufEnter * set formatoptions=jqlt
    autocmd BufEnter * if &syntax == '' | :filetype detect | endif
  augroup END
  ]], false)

-- highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

-- .bq → sql
vim.cmd([[
  autocmd BufEnter,BufNew *.bq setl filetype=sql
]])

-- exclude quickfix window from buffer list
-- https://stackoverflow.com/questions/28613190/exclude-quickfix-buffer-from-bnext-bprevious
vim.cmd([[
  augroup qf
      autocmd!
      autocmd FileType qf set nobuflisted
  augroup END
]])


vim.cmd([[
  autocmd BufEnter,BufNew *.bq setl filetype=sql
]])

-- tmux
vim.cmd([[
  autocmd BufNewFile,BufRead {.,}tmux*.local nested setf tmux
]])

vim.cmd([[
  autocmd Filetype tex set updatetime=1000
]])

-- quiickfix window → force it to be full width
vim.cmd([[
  autocmd FileType qf wincmd J
]])

-- reload the vimrc and any files that are soured within it (this is what the nested command does)
-- called after writing the buffer containing $MYVIMRC and also manually triggered by <Leader>VR
-- also needs to be run once after opening nvim in order to make colors work for nvim-tree and bufferline
vim.cmd([[
  augroup VimReload
      autocmd!
      autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
      autocmd BufEnter * nested source $MYVIMRC
  augroup END
]])

-- vim.api.nvim_create_autocmd({ "cursormoved", "bufwinenter", "buffilepost" }, { */
--   callback = function() */
--     local winbar_filetype_exclude = { */
--       "help", */
--       "startify", */
--       "dashboard", */
--       "packer", */
--       "neogitstatus", */
--       "nvimtree", */
--       "trouble", */
--       "alpha", */
--       "lir", */
--       "outline", */
--       "spectre_panel", */
--       "toggleterm", */
--     } */

--     if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then */
--       vim.opt_local.winbar = nil */
--       return */
--     end */

--     local value = require("plugins.winbar").gps() */

--     if value == nil then */
--       value = require("plugins.winbar").filename() */
--     end */

--     vim.opt_local.winbar = value */
--   end, */
-- }) */
