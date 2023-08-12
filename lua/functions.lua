-- toggle the quickfix window
-- in mappings.lua gq is mapped to this
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

-- blog post
vim.cmd [[
function! s:NewPost(fn)
  execute "e " . "~/projects/websites/blog/data/blog/" . a:fn . ".md"
endfunction
command! -nargs=1 Mp call s:NewPost(<q-args>)
]]


-- convert ascii typographuc quotes to normal quotes including slanty quotes,
function Convert_smart_and_fancy_ascii_chars_to_normal_chars()
  vim.cmd([[
    %!iconv -f utf-8 -t ascii//translit
    echom "ascii chars converted!"
    w
  ]])
end

-- clear registers and overwrite shada file so that register state is persisted
vim.cmd [[
function! ClearAllRegisters()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
    wsh!
    echom "cleared all registers. Inspect with :reg"
endfunction

command! ClearAllRegisters call ClearAllRegisters()
]]

vim.cmd [[
function! ClearLetterRegisters()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
    wsh!
    echom "cleared letter registers. Inspect with :reg"
endfunction

command! ClearLetterRegisters call ClearLetterRegisters()
]]

vim.cmd [[
function! ClearNumberRegisters()
    let regs='0123456789'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
    wsh!
    echom "reset registers 1 - 9. Inspect with :reg"
endfunction

command! ClearNumberRegisters call ClearNumberRegisters()
]]
