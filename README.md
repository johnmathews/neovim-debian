# Notes about this Neovim config

## Marks

1. create next sign: 

## Gitsigns

1. blame current line `<leader>sb`
2. stage buffer `<leader>sS`
3. Symbols:
    * `|` - added or changed
    * `_` - deleted
    * `-` - top delete
    * `~` - change number

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
   - Search for a string in your current working directory and get results live as you type,
     respects .gitignore. (Requires ripgrep)
1. more text
   - enables passing arguments to ripgrep
       - ` --no-ignore` - searches inside files ignored by git
       - `-tpy` or `--type python`- searches only in files with .py extension. E.g.: `-t*` where * is the file extension
   - `:lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>` 
   - [ripgrep commands](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md)
   - [extension](https://github.com/nvim-telescope/telescope-live-grep-args.nvim)
2. vim command history
   - a history of anything done in `EX` mode
   - \<tab\>tc
3. search history
4. keymaps
5. git
    - commits
    - branches
    - status
    - bcommits
6. resume
    - whatever you were doing last in telescope
    - \<tab\>z
7. autocommands
8. treesitter things
9. vim options
10. help files
11. projects

### Extensions

- fzf [fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
    - this gives better performance and sorting behavior. Also includes FZF syntax: \!, \', \^, \$
- projects
- harpoon
- live_grep_args [repo](https://github.com/nvim-telescope/telescope-live-grep-args.nvim)
- smart_history

