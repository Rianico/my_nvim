-- ensure the packer plugin manager is installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "git@github.com:wbthomason/packer.nvim.git", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

require("basic")
require("plugins")
require("keybindings")
require("theme")

-- for lsp
require("lsp.mason")
require("lsp.rust-tools")
require("lsp.null-ls")
require("lsp.nvim-treesitter")
require("lsp.formatting")
require("lsp.luasnip")
require("lsp.fidget")
require("lsp.cmp")
require("lsp.lspsaga")
require("lsp.lsp-signature")
require("lsp.trouble")

-- for status/winbar
require("plugin-config.lua-line")

-- other
require("plugin-config.hop")
require("plugin-config.nvim-tree")
require("plugin-config.comment")
require("plugin-config.vista")

-- mini.vim
require("plugin-config.mini")

-- the first run will install packer and our plugins
if packer_bootstrap then
	local packer = require("packer")
	packer.init({ git = { default_url_format = "git@github.com:%s" } })
	packer.sync()
	return
end
