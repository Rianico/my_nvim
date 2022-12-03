local colorscheme = "gruvbox-material"
if colorscheme == "gruvbox-material" then
	vim.notify("gruvbox_material")
	vim.g.gruvbox_material_background = "soft"
	vim.g.gruvbox_material_foreground = "soft"
	vim.g.gruvbox_material_disable_italic_comment = 1
	vim.g.gruvbox_material_diagnostic_text_highlight = 1
	vim.g.gruvbox_material_diagnostic_line_highlight = 1
	local status_ok, lualine = pcall(require, "lualine")
	if status_ok then
		lualine.setup({
			options = {
				theme = "gruvbox-material",
			},
		})
	end
end
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not Found")
	return
end
