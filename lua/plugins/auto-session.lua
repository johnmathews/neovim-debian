-- https://dockyard.com/blog/2018/06/01/simple-vim-session-management-part-1
-- this is a custom variable to be used with a custom command defined in the linked article
vim.g.session_dir = "~/.config/nvim/sessions/"

-- recommended 
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

require("auto-session").setup {
  log_level = "debug",
  auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" }, -- Suppress session create/restore if in one of these
  auto_save_enabled = true,
  pre_save_cmds = { "NvimTreeClose" },
  bypass_session_save_file_types = { "NvimTree" }
}

vim.cmd [[
  let g:auto_session_pre_save_cmds = ["tabdo NvimTreeClose"]
]]


-- this stops sessions from being loaded automatically
-- vim.cmd("let g:auto_session_enabled = v:false")
