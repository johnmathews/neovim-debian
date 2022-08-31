-- toggle the quickfix window
vim.cmd [[
  function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen 15
      setlocal norelativenumber
    else
      cclose
    endif
  endfunction
]]

-- blog snippet post
vim.cmd [[
  function! s:NewSnippet(fn)
    execute "e " . "~/projects/websites/blog/content/articles/snippets/" . a:fn . ".md"
  endfunction
  command! -nargs=1 Ms call s:NewSnippet(<q-args>)
]]

-- blog post
vim.cmd [[
function! s:NewPost(fn)
  execute "e " . "~/projects/websites/blog/content/articles/" . a:fn . ".md"
endfunction
command! -nargs=1 Mp call s:NewPost(<q-args>)
]]
