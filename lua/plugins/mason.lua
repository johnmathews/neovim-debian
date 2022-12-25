-- mason.vim names for language servers are not the same as the names used by lspconfig and mason-lspconfig.
-- e.g. lspconfig: sumneko_lua, mason.vim: lua-language-server

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

mason.setup()

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  return
end


mason_lspconfig.setup {
    ensure_installed = { "sumneko_lua", "rust_analyzer", "pyright" },
    automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, bufopts)

  -- this works in lua, js, ts files
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
  -- in lua, this doesnt do change code, but a menu opens, 
  vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

mason_lspconfig.setup_handlers({
   -- The first entry (without a key) will be the default handler
   -- and will be called for each installed server that doesn't have
   -- a dedicated handler.
   function (server_name) -- default handler (optional)
     require("lspconfig")[server_name].setup {
       on_attach = on_attach,
       flags = lsp_flags,
     }
   end,
   -- Next, you can provide targeted overrides for specific servers.
   ["sumneko_lua"] = function ()
     lspconfig.sumneko_lua.setup {
       on_attach = on_attach,
       flags = lsp_flags,
       settings = {
         Lua = {
           format = {
             enable = false
           },
           diagnostics = {
             globals = {
               "P",
               "vim",
               "require",
             },
             disable = {
               "trailing-space",
             }
           },
           workspace = {
             library = {
               [vim.fn.expand("$VIMRUNTIME/lua")] = true,
               [vim.fn.stdpath("config") .. "/lua"] = true,
             },
           },
         }
       }
     }
   end,
 })
