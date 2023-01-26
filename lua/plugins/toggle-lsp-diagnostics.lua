local status_ok, lsp_diagnostics = pcall(require, "toggle_lsp_diagnostics")

if not status_ok then
  return
end

lsp_diagnostics.init({
  start_on = true,
  underline = true,
  signs = true,
  virtual_text = false,
})

-- keymaps

local function map(mode, l, r, opts)
  opts = opts or {}
  opts.buffer = bufnr
  vim.keymap.set(mode, l, r, opts)
end

map("n", "<Tab>dd", "<Plug>(toggle-lsp-diag)", KeymapOptions("Diagnostics: Toggle signs and vtext")) -- :ToggleDiag
map("n", "<Tab>ds", "<Plug>(toggle-lsp-diag-signs)", KeymapOptions("Diagnostics: Toggle signs"))
map("n", "<Tab>dt", "<Plug>(toggle-lsp-diag-vtext)", KeymapOptions("Diagnostics: Toggle virtual text"))

map("n", "<Tab>df", "<Plug>(toggle-lsp-diag-off)", KeymapOptions("Diagnostics: Off")) --:ToggleDiagOfF
map("n", "<Tab>dn", "<Plug>(toggle-lsp-diag-on)", KeymapOptions("Diagnostics: On")) -- :ToggleDiagOn
