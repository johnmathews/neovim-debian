return {
  -- Schema: https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json
  -- help: https://github.com/sumneko/lua-language-server/wiki/Setting#working-example 
  settings = {
    Lua = {
      diagnostics = {
        globals = {
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
    },
  },
}
