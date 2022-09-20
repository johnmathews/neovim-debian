setlocal autoindent " Copy indent from current line when starting a new line (typing <CR> in Insert mode or when using the "o" or "O" command)
setlocal cindent " Get the amount of indent for line {lnum} according the C indenting rules, as with 'cindent'. The indent is counted in spaces, the value of 'tabstop' is relevant.
setlocal tabstop=2 " number of spaces that a tab is equal to
setlocal softtabstop=2 " number of spaces that a tab is equal to while performing editing operations "
setlocal shiftwidth=2
setlocal expandtab " In Insert mode: Use the appropriate number of spaces to insert a <Tab>.  Spaces are used in indents with the '>' and '<' commands and when 'autoindent' is on.
setlocal smarttab " When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.

setlocal textwidth=79
setlocal autoindent
setlocal fileformat=unix
setlocal nowrap

" setlocal colorcolumn=80,100
highlight ColorColumn ctermbg=red ctermfg=red guifg=red guibg=blue

" ========== ALE ==========
" let b:ale_linters = ['eslint']
" let b:ale_fixers = ['eslint', 'remove_trailing_lines', 'trim_whitespace']
" let b:ale_linters = ['eslint', 'prettier']
" let b:ale_fixers = ['eslint', 'prettier', 'importjs', 'prettier_eslint', 'standard', 'remove_trailing_lines', 'trim_whitespace']

let b:ale_warn_about_trailing_whitespace = 1
let b:ale_pattern_options = {'\.min.js$': {'ale_enabled': 0}}


" ===== jsBeautify =====
nnoremap <buffer>  <c-f> :call JsBeautify()<cr>

" ==== console.log() something =====
" vnoremap <buffer> <localleader>p y<esc>oconsole.log(`--- debug <esc>gpa: ${<esc>gpa}`);<ESC>
vnoremap <buffer> <localleader>p y<esc>oconsole.log('--- debug <esc>gpa: ', <esc>gpa);<ESC>
nnoremap <buffer> <Localleader>p <esc>oconsole.log(`--- debug <esc>gpa: ${<esc>gpa}`);<ESC>
