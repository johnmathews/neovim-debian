-- sets formatoptions to jqlt
-- if syntax isnt set, detect the filetype
-- vim.api.nvim_exec([[
--   augroup foo
--     au!
--     autocmd BufEnter * set formatoptions=jqlt
--     autocmd BufEnter * if &syntax == '' | :filetype detect | endif
--   augroup END
-- ]], false)

-- highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])


vim.cmd([[
  augroup RedrawOnFocusGained
    autocmd!
    autocmd FocusGained * :redraw!
  augroup end
]])

-- bigquery files should be sql filetype .bq → sql
vim.cmd([[
  autocmd BufEnter,BufNew *.bq setl filetype=sql
]])

-- exclude quickfix window from buffer list
-- https://stackoverflow.com/questions/28613190/exclude-quickfix-buffer-from-bnext-bprevious
-- vim.cmd([[
--   augroup qf
--       autocmd!
--       autocmd FileType qf set nobuflisted
--   augroup END
-- ]])


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

-- WINBAR USING LSPSAGA
-- ====================
local function config_winbar_or_statusline()
  local exclude = {
    ['terminal'] = true,
    ['toggleterm'] = true,
    ['prompt'] = true,
    ['NvimTree'] = true,
    ['help'] = true,
    ['TelescopePrompt'] = true
  }
  if exclude[vim.bo.filetype] then
    vim.wo.winbar = ""
  elseif not vim.api.nvim_win_get_config(0).zindex then
    -- https://nvimdev.github.io/lspsaga/breadcrumbs/
    vim.wo.winbar = require('lspsaga.symbol.winbar').get_bar() or " "
  end
end

local events = { 'BufEnter', 'BufWinEnter', 'CursorMoved' }
vim.api.nvim_create_autocmd(events, {
  pattern = '*',
  callback = function() config_winbar_or_statusline() end,
})

-- update symbols in LSP Saga
vim.api.nvim_create_autocmd('User', {
  pattern = 'LspsagaUpdateSymbol',
  callback = function() config_winbar_or_statusline() end,
})

-- set linenumber in telescope previews
vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number"
