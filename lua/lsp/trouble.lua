local keybindings = require("keybindings")
local icons = {
	diagnostic = require("ui.icons").get("diagnostics", false),
	misc = require("ui.icons").get("misc", false),
}
require("trouble").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
	position = "bottom", -- position of the list can be: bottom, top, left, right
	height = 32, -- height of the trouble list when position is top or bottom
	width = 50, -- width of the list when position is left or right
	icons = true, -- use devicons for filenames
	mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
	fold_open = "", -- icon used for open folds
	fold_closed = "", -- icon used for closed folds
	group = true, -- group results by file
	padding = true, -- add an extra new line on top of the list
	action_keys = keybindings.trouble_action_keys, -- key mappings for actions in the trouble list
	indent_lines = true, -- add an indent guide below the fold icons
	auto_open = false, -- automatically open the list when you have diagnostics
	auto_close = false, -- automatically close the list when you have no diagnostics
	auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
	auto_fold = true, -- automatically fold a file trouble list at creation
	auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
	signs = {
		-- icons / text used for a diagnostic
		error = icons.diagnostic.Error,
		warning = icons.diagnostic.Warning,
		hint = icons.diagnostic.Hint,
		information = icons.diagnostic.Information,
		other = icons.misc.Ghost,
	},
	use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
})

keybindings.trouble_mapping()
