local status, navic = pcall(require, "nvim-navic")
if not status then
	vim.notify("nvim-navic not found")
	return
end

local on_attach = require("keybindings").on_attach
local on_attach_navic = function(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
	on_attach(client, bufnr)
end

require("lspconfig")["rust_analyzer"].setup({
	on_attach = on_attach_navic,
})
require("lspconfig")["jdtls"].setup({
	on_attach = on_attach_navic,
})
