# Notes about this Neovim config

## Marks

1. `m,` - create next sign 
2. `m;` - toggle next available mark at current line
3. `dmx` - delete mark x
4. `dm<space>` - delete all marks in current buffer

5. `m:` - preview mark
6. `m]` - next mark
7. `m[` - previous mark

### Bookmarks

Not sure what these are, check `h marks-bookmarks`

8. `m<0-9]` - Add a bookmark 




## Gitsigns

1. blame current line `<leader>sb`
2. stage buffer `<leader>sS`
3. Symbols:
   - `|` - added or changed
   - `_` - deleted
   - `-` - top delete
   - `~` - change number

## LSP

### LSP-Saga

## Finding stuff

Things that can be searched:

1. buffer names
   - \<tab\>r
   - `:lua require('telescope.builtin').buffers({ ignore_current_buffer = true, sort_mru = true })<CR>`
2. files
   - excludes git ignored files
   - \<tab\>f
3. all files
   - \<tab\>a
   - Command: `:Telescope find_files<CR>`
4. text
   - uses ripgrep, not FZF.
   - \<tab\>s
   - `:Telescope live_grep<CR>", { noremap = true, silent = true, desc = "Telescope ripgrep (not fuzzy)" }`
   - Search for a string in your current working directory and get results live
     as you type, respects .gitignore. (Requires ripgrep)
5. more text
   - enables passing arguments to ripgrep
     - ` --no-ignore` - searches inside files ignored by git
     - `-tpy` or `--type python`- searches only in files with .py extension.
       E.g.: `-t*` where \* is the file extension
   - `:lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>`
   - [ripgrep commands](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md)
   - [extension](https://github.com/nvim-telescope/telescope-live-grep-args.nvim)
6. vim command history
   - a history of anything done in `EX` mode
   - \<tab\>tc
7. search history
8. keymaps
9. git
   - commits
   - branches
   - status
   - bcommits
10. resume
    - whatever you were doing last in telescope
    - \<tab\>z
11. autocommands
12. treesitter things
13. vim options
14. help files
15. projects

### Extensions

- fzf [fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
  - this gives better performance and sorting behavior. Also includes FZF
    syntax: \!, \', \^, \$
- projects
- harpoon
- live_grep_args
  [repo](https://github.com/nvim-telescope/telescope-live-grep-args.nvim)
- smart_history
