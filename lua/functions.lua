-- toggle the quickfix window
-- vim.cmd [[
--   function! ToggleQuickFix()
--     if empty(filter(getwininfo(), 'v:val.quickfix'))
--       copen 15
--       setlocal norelativenumber
--     else
--       cclose
--     endif
--   endfunction
-- ]]

-- blog post
vim.cmd [[
function! s:NewPost(fn)
  execute "e " . "~/projects/websites/blog/data/blog/" . a:fn . ".md"
endfunction
command! -nargs=1 Mp call s:NewPost(<q-args>)
]]
