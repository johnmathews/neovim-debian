local status_ok, lsp_diagnostics = pcall(require, "toggle_lsp_diagnostics")

if not status_ok then
	return
end

lsp_diagnostics.init({
  start_on = true,
	underline = false,
  signs = true,
	virtual_text = false,
	-- virtual_text = {
	-- 	prefix = "",
	-- 	spacing = 2,
	-- },
})

-- keymaps
vim.cmd "nmap <Tab>a <Plug>(toggle-lsp-diag)"
vim.cmd "nmap <Tab>s <Plug>(toggle-lsp-diag-signs)"
vim.cmd "nmap <Tab>v <Plug>(toggle-lsp-diag-vtext)"

vim.cmd "nmap <leader>tlu <Plug>(toggle-lsp-diag-underline)"
vim.cmd "nmap <leader>tlp <Plug>(toggle-lsp-diag-update_in_insert)"

vim.cmd "nmap <leader>tldd <Plug>(toggle-lsp-diag-default)"
vim.cmd "nmap <leader>tldo <Plug>(toggle-lsp-diag-off)"
vim.cmd "nmap <leader>tldf <Plug>(toggle-lsp-diag-on)"
