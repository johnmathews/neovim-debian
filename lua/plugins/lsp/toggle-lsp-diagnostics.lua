local status_ok, lsp_diagnostics = pcall(require, "toggle_lsp_diagnostics")

if not status_ok then
  return
end

lsp_diagnostics.init({
  start_on = true,
  underline = true,
  signs = true,
  virtual_text = true,
  -- virtual_text = {
  -- 	prefix = "",
  -- 	spacing = 2,
  -- },
})

-- keymaps

local function map(mode, l, r, opts)
  opts = opts or {}
  opts.buffer = bufnr
  vim.keymap.set(mode, l, r, opts)
end


map("n", "lda", "<Plug>(toggle-lsp-diag)", KeymapOptions("Diagnostics: Toggle signs and vtext"))
map("n", "lds", "<Plug>(toggle-lsp-diag-signs)", KeymapOptions("Diagnostics: Toggle signs"))
map("n", "ldv", "<Plug>(toggle-lsp-diag-vtexts)", KeymapOptions("Diagnostics: Toggle virtual text"))

map("n", "ldu", "<Plug>(toggle-lsp-diag-underline)", KeymapOptions("Diagnostics: Toggle underline"))
map("n", "ldp", "<Plug>(toggle-lsp-diag-update_in_insert)", KeymapOptions("Diagnostics: Toggle update_in_insert"))

map("n", "ldt", "<Plug>(toggle-lsp-diag-default)", KeymapOptions("Diagnostics: Toggle default settings"))
map("n", "ldf", "<Plug>(toggle-lsp-diag-off)", KeymapOptions("Diagnostics: Off"))
map("n", "ldn", "<Plug>(toggle-lsp-diag-on)", KeymapOptions("Diagnostics: On"))
