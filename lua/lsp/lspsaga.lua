local icons = {
	diagnostics = require("ui.icons").get("diagnostics", true),
	ui = require("ui.icons").get("ui", true),
}

local keybindings = require("keybindings")

local function set_sidebar_icons()
	-- Set icons for sidebar.
	local diagnostic_icons = {
		Error = icons.diagnostics.Error_alt,
		Warn = icons.diagnostics.Warning_alt,
		Info = icons.diagnostics.Information_alt,
		Hint = icons.diagnostics.Hint_alt,
	}
	for type, icon in pairs(diagnostic_icons) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl })
	end
end

set_sidebar_icons()

require("lspsaga").setup({
	-- preview lines above of lsp_finder
	preview = {
		lines_above = 8,
		lines_below = 10,
	},
	-- preview lines of lsp_finder and definition preview
	max_preview_lines = 20,
	-- use emoji lightbulb in default
	finder_request_timeout = 6000,
	ui = {
		-- Border type can be single, double, rounded, solid, shadow.
		border = "rounded",
		winblend = 0,
		expand = "",
		collapse = "",
		preview = " ",
		code_action = "",
		diagnostic = "🐞",
		incoming = " ",
		outgoing = " ",
		hover = " ",
	},
	symbol_in_winbar = {
		enable = true,
		hide_keyword = true,
		folder_level = 2,
		respect_root = false,
		color_mode = true,
		in_custom = true,
		separator = " " .. icons.ui.Separator,
		show_file = true,
		-- define how to customize filename, eg: %:., %
		-- if not set, use default value `%:t`
		-- more information see `vim.fn.expand` or `expand`
		-- ## only valid after set `show_file = true`
		file_formatter = "",
	},
	-- show outline
	outline = {
		win_position = "right",
		win_with = "",
		win_width = 50,
		show_detail = true,
		auto_preview = true,
		auto_refresh = true,
		auto_close = true,
		custom_sort = nil,
		keys = {
			jump = "<CR>",
			expand_collapse = "u",
			quit = "q",
		},
	},
	finder = keybindings.lspsaga_finder_keys,
	code_action = {
		num_shortcut = true,
		show_server_name = true,
		extend_gitsigns = false,
		keys = keybindings.code_action_keys,
	},
	definition = keybindings.lspsaga_definition_keys,
	callhierarchy = {
		show_detail = false,
		keys = keybindings.lspsaga_callhierarchy_keys,
	},
	diagnostic = {
		on_insert = false,
		on_insert_follow = false,
		insert_winblend = 0,
		show_code_action = true,
		show_source = true,
		jump_num_shortcut = true,
		--1 is max
		max_width = 0.9,
		custom_fix = "<🦀️Fix>",
		custom_msg = "<🐞Diagnostic>",
		text_hl_follow = true,
		border_follow = false,
		keys = keybindings.lspsaga_diagnostic_keys,
	},
})

require("keybindings").lspsaga_mapping()
