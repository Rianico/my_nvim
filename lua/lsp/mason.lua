vim.api.nvim_command([[packadd lsp_signature.nvim]])
vim.api.nvim_command([[packadd lspsaga.nvim]])
vim.api.nvim_command([[packadd cmp-nvim-lsp]])

local nvim_lsp = require("lspconfig")
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

-- the servers that should be automatically installed
local lsp_servers = {
	"sumneko_lua",
	"clangd",
	"bashls",
	"cmake",
	"dockerls",
	"jsonls",
	"jdtls",
	"sqlls",
	"taplo",
	"yamlls",
	"tsserver",
	-- Set by rust-tools
	-- "rust_analyzer",
}

require("lspconfig.ui.windows").default_options.border = "single"

mason.setup({
	ui = {
		border = "single",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

mason_lsp.setup({
	ensure_installed = lsp_servers,
	automatic_installation = true,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = require("keybindings").on_attach

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, server in pairs(lsp_servers) do
	if server == "sumneko_lua" then
		nvim_lsp.sumneko_lua.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
				},
			},
		})
	else
		nvim_lsp[server].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end
end

require("lsp.formatting").configure_format_on_save()
