" F5 run python code (venv aware)
" F7 flake8 formatting check

setlocal list lcs=tab:\|\ 
setlocal tabstop=4
setlocal softtabstop=4
setlocal expandtab
setlocal shiftwidth=4
setlocal smarttab

setlocal textwidth=119
setlocal autoindent
setlocal nowrap

" augroup PreviewAutocmds
"   autocmd!
"   autocmd WinEnter * if &previewwindow | set syntax=python | endif
" augroup END

if exists('+colorcolumn')
    setlocal colorcolumn=121
else
    au! BufEnter <buffer> match ColorColumn /\%121v.*/
endif

" ====================== YAPF ===========================
" nnoremap <Leader>y :w<bar>:call system("yapf -i -l ".line(".")."-".line(".")." ".expand('%:p'))<CR><bar>:e<CR>
" nnoremap <Leader>y <ESC>V:!yapf<CR>
" xnoremap <leader>y :!yapf<CR>
" nnoremap <leader>y :0,$!yapf<Cr>

" ========== print variable and its value ===============
vnoremap <buffer> <localleader>p y<esc>oprint(f"--- {<esc>gpa = }")<ESC>
vnoremap <buffer> <localleader>o y<esc>oprint(f'''--- {<esc>gpa =<CR><BS><BS><BS>}''')<ESC>
nnoremap <buffer> <Localleader>p <esc>oprint(f"--- {<esc>gpa = }")<ESC>
nnoremap <buffer> <Localleader>o <esc>oprint(f'''--- {<esc>gpa =<CR><BS><BS><BS>}''')<ESC>

" ========== log variable and its value ================
vnoremap <buffer> <localleader>l y<esc>ologger.info(f"--- {<esc>gpa = }")<ESC>
nnoremap <buffer> <Localleader>l <esc>ologger.info(f"--- {<esc>gpa = }")<ESC>
