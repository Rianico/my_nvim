--- Check if a file or directory exists in this path
local function exists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

--- Check if a directory exists in this path
local function isdir(path)
	-- "/" works on both Unix and Windows
	return exists(path .. "/")
end

local install_path = os.getenv("HOME") .. "/.local/share/nvim/site/pack/packer/start/packer.nvim"
local is_exists = isdir(install_path)

if not is_exists then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
	local packer = require("packer")
	packer.sync()
end

require("plugins")
require("basic")
require("keybindings")
require("theme")

-- for lsp
require("lsp.mason")
require("lsp.metals")
require("lsp.null-ls")
require("lsp.nvim-treesitter")
require("lsp.luasnip")
require("lsp.cmp")
require("lsp.lspsaga")
require("lsp.lsp-signature")
require("lsp.trouble")
-- dap
require("plugin-config.dap")

-- beautify
require("plugin-config.noice")

-- for status/winbar
require("plugin-config.lua-line")
require("plugin-config.bufferline")

-- git
require("plugin-config.gitsigns")
-- terminal
require("plugin-config.toggleterm")
-- motion
require("plugin-config.leap")
-- file exploer
require("plugin-config.nvim-tree")
-- comment
require("plugin-config.comment")
-- symbol viewer
require("plugin-config.vista")
-- mini.vim: cursor_word, pairs, ai
require("plugin-config.mini")
require("plugin-config.colorizer")
-- marks
require("plugin-config/marks")
-- neoclip, manage your registers
require("plugin-config/neoclip")
-- fuzzy finder, can also integration with many plugins amazingly!
require("plugin-config.telescope")

if vim.g.neovide then
	vim.g.neovide_scale_factor = 1.3

	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	vim.g.neovide_scroll_animation_length = 0.9
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

	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	vim.g.neovide_transparency = 0.9
	vim.g.transparency = 0.8
	-- vim.g.neovide_background_color = '#0f1117'.printf('%x', float2nr(255 * g:transparency))
end

-- for ripgrep
if vim.fn.executable("rg") == 1 then
	vim.o.grepprg = "rg --vimgrep"
end
