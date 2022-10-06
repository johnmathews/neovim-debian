-- https://github.com/wfxr/minimap.vim


vim.cmd([[
  nnoremap <Leader>m :MinimapToggle<CR>
]])

vim.cmd([[
  let g:minimap_width=50
  let g:minimap_auto_start=1
  let g:minimap_auto_start_win_enter=1
  let g:minimap_git_colors=1
  let g:minimap_highlight_search=1
  let g:minimap_highlight_range=1
]])
