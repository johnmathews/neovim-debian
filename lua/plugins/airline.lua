
vim.cmd([[
  " let g:airline_theme='badwolf'
  let g:airline_theme='dracula'

  " list of buffers at top of window
  let g:airline#extensions#tabline#enabled = 1

  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  let g:airline_highlighting_cache = 1

  let g:airline_detect_crypt=1
  let g:airline_detect_modified=1
  let g:airline_detect_paste=1
  let g:airline_detect_spell=1
  let g:airline_detect_spelllang=1

  let g:airline_powerline_fonts = 1
  let g:airline_skip_empty_sections = 1

  let g:airline#extensions#fugitiveline#enabled = 1
  " let g:airline#extensions#gutentags#enabled = 1
  let g:airline#extensions#searchcount#enabled = 0
  let g:airline#extensions#tagbar#enabled = 1
  let g:airline#extensions#tagbar#flags = 'f'
  let g:airline#extensions#coc#enabled = 1
  let g:airline#extensions#ale#enabled = 1
  let g:airline#extensions#virtualenv#enabled = 1
  " let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['error', 'warning', 'x', 'y', 'z']]


  " airline plugin
  " see init.vim for section names, default layouts, variable names etc https://github.com/vim-airline/vim-airline/blob/master/autoload/airline/init.vim
  au User AirlineAfterInit let g:airline_section_a = airline#section#create(['obsession', 'linenr', 'maxlinenr', '%3p%%', ' %c ', 'mode', ' ', 'crypt', ' ', 'paste', ' ',  'spell', ' ',  'iminsert'])
  " au User AirlineAfterInit let g:airline_section_y = airline#section#create([])
  au User AirlineAfterInit let g:airline_section_z = airline#section#create([])
  au User AirlineAfterInit let g:airline_symbols.maxlinenr = ''
  au User AirlineAfterInit let g:airline_symbols.linenr = ''
]])
