# Notes about this Neovim config

## Telescope

Things that can be searched:

1. Buffers
   - `<tab>r`
   - Command: `:lua require('telescope.builtin').buffers({ ignore_current_buffer = true, sort_mru = true })<CR>`
2. Files in repo
   - `<tab>f`
   - Command: `<CMD>lua require'plugins.telescope'.find_files_fallback()<CR>` 
   - excludes git ignored files if in a git repository. If not in a git repository, searches all
     files.
1. All files
   - `<tab>a`
   - Command: `:Telescope find_files<CR>`
2. Text - whole project, respects .gitignore
   - `<tab>s`
   - Command: `:Telescope live_grep<CR>", { noremap = true, silent = true, desc = "Telescope ripgrep (not fuzzy)" }`
   - uses ripgrep, not FZF.
   - Search for a string in your current working directory, respects `.gitignore`. Requires Ripgrep.
3. Text - flexible
   - `<tab>x` 
   - Command: `:lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>`
   - enables passing arguments to ripgrep
     - ` --no-ignore` - searches inside files ignored by git
     - `-tpy` or `--type python`- searches only in files with .py extension.
   - [ripgrep commands](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md)
   - [extension](https://github.com/nvim-telescope/telescope-live-grep-args.nvim)
4. Your command history
   - `<tab>tc`
   - Command: `:Telescope command_history<CR>`
   - a history of anything done in `EX` mode
5. Your search history
   - `<tab>ts`
   - Command: `:Telescope search_history<CR>` 
6. Keymaps
   - `<tab>tk`
   - Command: `:Telescope keymaps<CR>`
7. Registers
   - `<tab>tr` 
   - Command: `:Telescope registers<CR>` 
8. Git
   - Commits
   - Branches
   - Status
   - Bcommits
9. Resume
    - whatever you were doing last in telescope
    - `<tab>z`
10. Autocommands
11. Treesitter things
12. Vim options
13. Help files
14. Projects

#### Telescope Extensions

- fzf 
  - [fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
  - this gives better performance and sorting behavior. (Also includes FZF syntax `\!`, `\'`, `\^`, `\$` )
- projects
- harpoon
- live_grep_args
  [repo](https://github.com/nvim-telescope/telescope-live-grep-args.nvim)
- smart_history


## Marks

1. `m,` - create next sign 
2. `m;` - toggle next available mark at current line
3. `dmx` - delete mark x
4. `dm<space>` - delete all marks in current buffer

5. `m:` - preview mark
6. `m]` - next mark
7. `m[` - previous mark

### Bookmarks

Not sure what these are, see `:h marks-bookmarks`

1. `m[0-9]` - Add a bookmark 




## Gitsigns

1. blame current line `<leader>sb`
2. Symbols:
   - `|` - added or changed
   - `_` - deleted
   - `-` - top delete
   - `~` - change number
3. stage buffer `<leader>sS`

## LSP

todo

1. Go to definition
2. Show references
3. Show documentation
4. Symbols map
5. Incoming

### LSP-Saga

1. LSP-Finder `<Leader>i`
2. Outline `<Leader>o`
3. Documentation window `K`
2. Code actions `<Leader>a`
3. Rename `<Leader>r`
4. Go to previous diagnostic `[e`
4. Go to previous error `[E`
4. Definition `gd`
5. Line or Cursor diagnostics `<Leader>cd`
