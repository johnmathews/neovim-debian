-- mason.vim names for language servers are not the same as the names used by lspconfig and mason-lspconfig.
-- e.g. lspconfig: sumneko_lua, mason.vim: lua-language-server

-- multiple spawn issues - caused by Packer lazyloading things, but not all things.
-- be careful about using `event = "VimEnter"` in plugins.lua, and other lazyloading techniques.
-- https://github.com/LunarVim/LunarVim/issues/2012

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
  ensure_installed = { "rust_analyzer", "tailwindcss", "lua_ls", "jsonls" },
  automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

function KeymapBufferOptions(args)
  local description = args.description or "no description"
  local bufnr = args.bufnr
  return {
    noremap = true,
    silent = true,
    desc = description,
    buffer = bufnr,
  }
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end,
    KeymapBufferOptions({ description = "LSP format buffer", bufnr = bufnr }))
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, KeymapOptions("Diagnostic - Open Location List")) -- view a list of errors and warnings
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, KeymapOptions("Diagnostic - Open Floating Window"))


  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, KeymapOptions("LSP Type Definition"))
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
    KeymapBufferOptions({ description = "LSP goto Declaration", bufnr = bufnr }))
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
    KeymapBufferOptions({ description = "LSP goto Definition", bufnr = bufnr }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
    KeymapBufferOptions({ description = "LSP goto Implementation", bufnr = bufnr }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references,
    KeymapBufferOptions({ description = "LSP goto references", bufnr = bufnr }))
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
    KeymapBufferOptions({ description = "LSP signature help", bufnr = bufnr }))

  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
    KeymapBufferOptions({ description = "LSP add workspace folder", bufnr = bufnr }))
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
    KeymapBufferOptions({ description = "LSP remove workspace folder", bufnr = bufnr }))
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, KeymapBufferOptions({ description = "LSP list workspace folders", bufnr = bufnr }))

  -- HANDLED BETTER BY LSPSAGA.
  --   vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  --   vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
  --   vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  --   vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  --   See `:help vim.lsp.*` for documentation on any of the below functions
  --   vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  --   vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  --   vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
end



local lsp_flags = {
  debounce_text_changes = 500,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

mason_lspconfig.setup_handlers({
  -- AVAILABLE SERVERS: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers

  -- The first entry (without a key) will be the default handler and will be called for
  -- each installed server that doesn't have a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
    }
  end,
  -- settings: https://github.com/sumneko/lua-language-server/wiki/Settings

  -- TO SEE ACTIVE CONFIG:
  -- :lua print(vim.inspect(vim.lsp.get_active_clients()))
  --
  -- dont use pylsp because ruff+pyright+black is enough
  -- ["pylsp"] = function() -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
  --   lspconfig.pylsp.setup {
  --     on_attach = on_attach,
  --     flags = lsp_flags,
  --     capabilities = capabilities,
  --     settings = {
  --       pylsp = {
  --         plugins = {
  --           black = { -- dont know if config is here or in null-ls
  --             enabled = false,
  --             line_length = 120,
  --             preview = true,
  --           },
  --           pycodestyle = {
  --             ignore = {
  --               'E501', -- line too long
  --               'F401', -- unused import
  --               'W503', -- line break before binary operator
  --             },
  --             maxLineLength = 110
  --           }
  --         }
  --       }
  --     }
  --   }
  -- end,
  -- ["pyright"] = function()
  --   lspconfig.pyright.setup {
  --     on_attach = on_attach,
  --     flags = lsp_flags,
  --     capabilities = capabilities,
  --     settings = {
  --       -- pyright = {
  --       --   disableOrganizeImports = true,
  --       -- },
  --       python = {
  --         analysis = {
  --           useLibraryCodeForTypes = true,
  --           typeCheckingMode = "basic",
  --           autoSearchPaths = true,
  --           diagnosticSeverityOverrides = {
  --             reportUnusedVariable = false, -- or anything
  --           },
  --         }
  --       }
  --     }
  --   }
  -- end,
  -- ["ruff_lsp"] = function()
  --   lspconfig.ruff_lsp.setup {
  --     on_attach = function(client, _) client.server_capabilities.hoverProvider = false end,
  -- }
  -- end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
      settings = {
        Lua = {
          telemetry = { enable = false },
          runtime = {
            version = 'LuaJIT',
            path = vim.fn.expand("$VIMRUNTIME/lua"),
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
          format = {
            enable = true,
            default_config = {
              indent_type = "Spaces",
              indent_width = 2,
              line_length = 180, -- doesnt work
            },
          },
          completion = {
            callSnippet = "Both",
          },
          diagnostics = {
            globals = {
              "P",
              "pcall",
              "string",
              "vim",
              "require",
              "KeymapOptions",
              "KeymapBufferOptions",
            },
            disable = {
              "trailing-space",
            }
          },
        }
      }
    }
  end,
})
