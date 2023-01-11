setlocal smarttab
setlocal softtabstop=4
setlocal noautoindent " if previous line is indented, don't make new line also indented

setlocal tabstop=4
setlocal shiftwidth=4 " this is how many spaces a tab is.
setlocal expandtab
setlocal linebreak " Wrap lines at convenient points, avoid wrapping a line in the middle of a word.

setlocal nowrap
setlocal scrolloff=3 " The number of screen lines to keep above and below the cursor

setlocal textwidth=80
setlocal colorcolumn=81
" highlight ColorColumn ctermbg=red ctermfg=red guifg=red guibg=darkcyan

" add text width to autoformat options
" setlocal formatoptions+=t

setlocal spell
setlocal spelllang=en_us,en_gb

" toggle visibility of tab chars, EOL chars, CR chars
setlocal nolist

" don't insert 2 spaces after a '.','?' or '!'
setlocal nojoinspaces

" show text normally. no folding
setlocal conceallevel=0
let g:indentLine_conceallevel = 0

lua << EOF
  vim.api.nvim_set_keymap("n", "<Leader>p", ":Glow<CR>", KeymapOptions("Preview markdown"))
EOF

" Stop telling me underscores are errors:
syn match markdownError "\w\@<=\w\@="

" Rainbow parenthesis turned off
let g:rainbow_active = 0


let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace_except_double']
let b:ale_warn_about_trailing_whitespace = 1

" select some text and make it a hyperlink
vnoremap ml "lxa[(F["lpf("lp


" format paragraph
" command! FormatParagraph normal! vipgw`^
command! FormatParagraph normal! gwip
nnoremap <leader>fp :FormatParagraph<CR>
vnoremap <leader>fp gw

" make  row Tile Case
nnoremap <buffer> <leader>mt :s/\<./\u&/g<bar>:nohlsearch<bar><esc><C-O>
vnoremap <buffer> <leader>mt :s/\<./\u&/g<bar>:nohlsearch<bar><esc><C-O>

" make text bold
nnoremap <buffer> <leader>mb ebi**<ESC>ea**<space><ESC>
vmap <buffer> <leader>mb c**<ESC>gcP

" make text italic
nnoremap <buffer> <leader>mi ebi*<ESC>ea*<ESC>
vmap <buffer> <leader>mi c__<ESC>gcP

" make code block
nnoremap <buffer> <leader>mc ebi`<ESC>ea`<ESC>
vmap <buffer> <leader>mc c``<ESC>gcP
