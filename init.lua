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

require("plugins")

-- the first run will install packer and our plugins
if packer_bootstrap then
	local packer = require("packer")
	packer.init({ git = { default_url_format = "git@github.com:%s" } })
	packer.sync()
	return
end

require("basic")
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

if vim.g.neovide then
	vim.g.neovide_scale_factor = 1.35

	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	vim.g.neovide_scroll_animation_length = 0.6
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_remember_window_size = true

	-- for mac
	local global = require("global")
	if global.is_mac then
		vim.g.neovide_input_use_logo = true
		vim.g.neovide_input_macos_alt_is_meta = true
	end

	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_vfx_mode = "torpedo"
	vim.g.neovide_cursor_trail_length = 0.5
	vim.g.neovide_cursor_vfx_opacity = 200.0
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
	vim.g.neovide_cursor_vfx_particle_density = 7.0
	vim.g.neovide_cursor_vfx_particle_speed = 10.0
	vim.g.neovide_cursor_vfx_particle_phase = 1.5
	vim.g.neovide_cursor_vfx_particle_curl = 1.0
end
