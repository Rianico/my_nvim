local icons = {
	diagnostics = require("ui.icons").get("diagnostics", true),
	kind = require("ui.icons").get("kind", true),
	type = require("ui.icons").get("type", true),
	ui = require("ui.icons").get("ui", true),
}

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

local function get_palette()
	-- Default behavior: return lspsaga's default palette.
	local palette = require("lspsaga.highlight").get_colors()
	palette.peach = palette.orange
	palette.flamingo = palette.orange
	palette.rosewater = palette.yellow
	palette.mauve = palette.violet
	palette.sapphire = palette.blue
	palette.maroon = palette.orange
	return palette
end

set_sidebar_icons()

local colors = get_palette()

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
		-- Currently, only the round theme exists
		theme = "round",
		-- This option only works in Neovim 0.9
		title = true,
		-- Border type can be single, double, rounded, solid, shadow.
		border = "rounded",
		winblend = 0,
		expand = "",
		collapse = "",
		preview = " ",
		code_action = "🦀️",
		diagnostic = "🐞",
		incoming = " ",
		outgoing = " ",
		hover = " ",
		kind = {
			-- Kind
			Class = { icons.kind.Class, colors.yellow },
			Constant = { icons.kind.Constant, colors.peach },
			Constructor = { icons.kind.Constructor, colors.sapphire },
			Enum = { icons.kind.Enum, colors.yellow },
			EnumMember = { icons.kind.EnumMember, colors.teal },
			Event = { icons.kind.Event, colors.yellow },
			Field = { icons.kind.Field, colors.teal },
			File = { icons.kind.File, colors.rosewater },
			Function = { icons.kind.Function, colors.blue },
			Interface = { icons.kind.Interface, colors.yellow },
			Key = { icons.kind.Keyword, colors.red },
			Method = { icons.kind.Method, colors.blue },
			Module = { icons.kind.Module, colors.blue },
			Namespace = { icons.kind.Namespace, colors.blue },
			Number = { icons.kind.Number, colors.peach },
			Operator = { icons.kind.Operator, colors.sky },
			Package = { icons.kind.Package, colors.blue },
			Property = { icons.kind.Property, colors.teal },
			Struct = { icons.kind.Struct, colors.yellow },
			TypeParameter = { icons.kind.TypeParameter, colors.maroon },
			Variable = { icons.kind.Variable, colors.peach },
			-- Type
			Array = { icons.type.Array, colors.peach },
			Boolean = { icons.type.Boolean, colors.peach },
			Null = { icons.type.Null, colors.yellow },
			Object = { icons.type.Object, colors.yellow },
			String = { icons.type.String, colors.green },
			-- ccls-specific iconss.
			TypeAlias = { icons.kind.TypeAlias, colors.green },
			Parameter = { icons.kind.Parameter, colors.blue },
			StaticMethod = { icons.kind.StaticMethod, colors.peach },
		},
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
		click_support = function(node, clicks, button, modifiers)
			-- To see all avaiable details: vim.pretty_print(node)
			local st = node.range.start
			local en = node.range["end"]
			if button == "l" then
				if clicks == 2 then
					-- double left click to do nothing
				else -- jump to node's starting line+char
					vim.fn.cursor(st.line + 1, st.character + 1)
				end
			elseif button == "r" then
				if modifiers == "s" then
					print("lspsaga") -- shift right click to print "lspsaga"
				end -- jump to node's ending line+char
				vim.fn.cursor(en.line + 1, en.character + 1)
			elseif button == "m" then
				-- middle click to visual select node
				vim.fn.cursor(st.line + 1, st.character + 1)
				vim.api.nvim_command([[normal v]])
				vim.fn.cursor(en.line + 1, en.character + 1)
			end
		end,
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
	finder = {
		jump_to = "p",
		edit = { "o", "<CR>" },
		vsplit = "v",
		split = "s",
		tabe = "t",
		tabnew = "T",
		quit = { "q", "<ESC>" },
	},
	code_action = {
		num_shortcut = true,
		show_server_name = false,
		extend_gitsigns = true,
		keys = {
			-- string | table type
			quit = { "q", "<ESC>" },
			exec = "<CR>",
		},
	},
	definition = {
		edit = "<Leader>e",
		vsplit = "<Leader>v",
		split = "<Leader>s",
		tabe = "<Leader>t",
		quit = { "q", "<ESC>" },
	},
	callhierarchy = {
		show_detail = false,
		keys = {
			edit = "e",
			vsplit = "v",
			split = "s",
			tabe = "t",
			jump = "<Tab>",
			quit = { "q", "<ESC>" },
			expand_collapse = "u",
		},
	},
	diagnostic = {
		show_code_action = true,
		show_source = true,
		jump_num_shortcut = true,
		--1 is max
		max_width = 0.9,
		custom_fix = "<🦀️Fix>",
		custom_msg = "<🐞Diagnostic>",
		text_hl_follow = false,
		-- DiagnostcText = {
		-- 	icons.diagnostics.Error,
		-- 	icons.diagnostics.Warning,
		-- 	icons.diagnostics.Information,
		-- 	icons.diagnostics.Hint,
		-- },
		border_follow = false,
		keys = {
			exec_action = "<CR>",
			quit = { "q", "<ESC>" },
			-- 跳转到 code action
			go_action = "g",
		},
	},
})
require("keybindings").lspsaga_mapping()
