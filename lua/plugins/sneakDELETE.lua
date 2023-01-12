vim.cmd([[
  let g:sneak#s_next = 1
  map f <Plug>Sneak_f
  map F <Plug>Sneak_F
  map t <Plug>Sneak_t
  map T <Plug>Sneak_T
  " rebinding s and S removes sneaks double char search. what is the benefit of this? why did you do it?
  map s <Plug>Sneak_;
  map S <Plug>Sneak_,

  " this stops sneak purple highlighting stuff
  " https://github.com/justinmk/vim-sneak/issues/171
  autocmd ColorScheme * hi! link Sneak Normal
]])

