-- vim.cmd([[

--   let g:plug_window = 'noautocmd vertical topleft new'

--   autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


--   " Keybinds
--   nnoremap <expr> <leader>n g:NERDTree.IsOpen() ? ':NERDTreeClose<CR>' : @% == '' ? ':NERDTree<CR>' : ':NERDTreeFind<CR>'
--   nnoremap <leader>N :NERDTreeFind


--   " prevent lag
--   let g:NERDTreeLimitedSyntax = 1
--   let g:NERDTreeHighlightCursorline = 0

--   let g:NERDTreeSyntaxDisableDefaultExtensions = 1
--   let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
--   let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1
--   let g:NERDTreeSyntaxEnabledExtensions = ['lua', 'vim', 'bq', 'sql', 'txt', 'vim', 'py', 'js', 'css', 'html'] " enabled extensions with default colors
--   let g:NERDTreeSyntaxEnabledExactMatches = ['node_modules', 'favicon.ico'] " enabled exact matches with default colors
-- ]])
