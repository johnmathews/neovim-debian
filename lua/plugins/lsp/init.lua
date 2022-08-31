local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("plugins.lsp.lsp-installer")
require("plugins.lsp.handlers").setup()  -- keybinds in here!
require("plugins.lsp.null-ls")
require("plugins.lsp.toggle-lsp-diagnostics")
require("plugins.lsp.lsp-utils")

-- formatting
-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/formatting.lua -- general setup
-- https://github.com/lukas-reineke/lsp-format.nvim -- a plugin
