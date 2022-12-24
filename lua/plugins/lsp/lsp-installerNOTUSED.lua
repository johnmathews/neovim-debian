local lsp_installer_status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_status_ok then
  return
end

lsp_installer.setup {}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

for _, server in ipairs { "clangd", "eslint", "ltex", "stylua" } do
  lspconfig[server].setup { on_attach = on_attach }
end
  
lspconfig.luacheck.setup {
  on_attach = on_attach,
}

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
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

lspconfig.pyright.setup {
  on_attach = on_attach,
}
lspconfig.jsonls.setup {
  on_attach = on_attach,
}
