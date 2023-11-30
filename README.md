# Notes about this Neovim config

## Finding stuff

Things that can be searched:

1. buffer names 
   - <tab>r
   - `:lua require('telescope.builtin').buffers({ ignore_current_buffer = true, sort_mru = true })<CR>`
2. files
   - excludes git ignored files
   - <tab>f
3. all files
   - <tab>a
   - Command: `:Telescope find_files<CR>`
4. text
   - this is ripgrep, not FZF. 
   - <tab>s
   - `:Telescope live_grep<CR>", { noremap = true, silent = true, desc = "Telescope ripgrep (not fuzzy)" }`
5. more text
   - you can add args, like 
       - ` --no-ignore` - searches inside files ignored by git
       - `todo` - searches only in files with .py extension
   - `:lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>` 
6. vim command history
   - a history of anything done in `EX` mode
   - <tab>tc

### Extensions

- fzf
- projects
- harpoon
- live_grep_args
- smart_history

