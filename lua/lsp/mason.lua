vim.api.nvim_command([[packadd lsp_signature.nvim]])
vim.api.nvim_command([[packadd lspsaga.nvim]])
vim.api.nvim_command([[packadd cmp-nvim-lsp]])

local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local util = require("lspconfig/util")
require("lspconfig.ui.windows").default_options.border = "rounded"

local on_attach = require("keybindings").default_on_attach
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- the servers that should be automatically installed
local lsp_servers = {
	-- lua
	"lua_ls",
	"clangd",
	"bashls",
	"bufls",
	"cmake",
	"dockerls",
	"jdtls",
	-- toml
	"taplo",
	-- json
	"jsonls",
	-- xml
	"lemminx",
	-- markdown
	"marksman",
	-- go
	"gopls",
}

mason.setup()
mason_lsp.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	pip = {
		-- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
		upgrade_pip = true,
	},
	ensure_installed = lsp_servers,
	automatic_installation = true,
})

mason_lsp.setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		-- Use an on_attach function to only map the following keys
		-- after the language server attaches to the current buffer
		lspconfig[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
})

local lspconfig = require("lspconfig")

lspconfig.gopls.setup({
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
})

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			format = {
				enable = true,
				-- Put format options here
				-- NOTE: the value should be String!
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
				},
			},
		},
	},
})

vim.b.rustfmt_autosave = 1
-- https://rust-lang.github.io/rustfmt/?version=v1.6.0&search=
vim.g.rustfmt_options = '--config imports_granularity="Module"'

vim.g.rustaceanvim = {
	-- Plugin configuration
	tools = {
		executors = "toggleterm",
		test_executor = "background",
		hover_actions = {
			auto_focus = true,
		},
	},
	-- LSP configuration
	server = {},
	-- DAP configuration
	dap = {},
}
