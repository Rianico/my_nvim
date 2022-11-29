-- ensure the packer plugin manager is installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

require("basic")
require("keybindings")
require("plugins")
require("theme")

-- for lsp
require("plugin-config.mason")
require("plugin-config.null-ls")
require("plugin-config.nvim-treesitter")

-- for status/winbar
require("plugin-config.nvim-navic")
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
	require("packer").sync()
	return
end
