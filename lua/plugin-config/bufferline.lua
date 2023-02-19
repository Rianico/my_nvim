vim.opt.termguicolors = true
vim.opt.mousemoveevent = true
local icons = {
	ui = require("ui.icons").get("ui", true),
	documents = require("ui.icons").get("documents", true),
	diagnostics = require("ui.icons").get("diagnostics", true),
}
require("bufferline").setup({
	options = {
		mode = "buffers", -- set to "tabs" to only show tabpages instead
		numbers = "both", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		indicator = {
			icon = "▎", -- this should be omitted if indicator style is not 'icon'
			style = "icon", -- 'icon' | 'none',
		},
		buffer_close_icon = icons.ui.Close,
		modified_icon = icons.ui.Modified_alt,
		close_icon = icons.ui.Close_alt,
		left_trunc_marker = icons.ui.Left,
		right_trunc_marker = icons.ui.Right,
		--- name_formatter can be used to change the buffer's label in the bufferline.
		--- Please note some names can/will break the
		--- bufferline so use this at your discretion knowing that it has
		--- some limitations that will *NOT* be fixed.
		name_formatter = function(buf) -- buf contains:
			-- name                | str        | the basename of the active file
			-- path                | str        | the full path of the active file
			-- bufnr (buffer only) | int        | the number of the active buffer
			-- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
			-- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
		end,
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		truncate_names = true, -- whether or not tab names should be truncated
		tab_size = 18,
		diagnostics = "nvim_lsp", -- "coc"
		diagnostics_update_in_insert = false,
		-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			if context.buffer:current() then
				return ""
			end
			local icon = level:match("error") and icons.diagnostics.Error_alt or icons.diagnostics.Warning
			return " " .. icon .. count
		end,
		-- NOTE: this will be called a lot so don't do any heavy processing here
		custom_filter = function(buf_number, buf_numbers)
			-- filter out filetypes you don't want to see
			if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
				return true
			end
			-- filter out by buffer name
			if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
				return true
			end
			-- filter out based on arbitrary rules
			-- e.g. filter out vim wiki buffer from tabline in your work repo
			if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
				return true
			end
			-- filter out by it's index number in list (don't show first buffer)
			if buf_numbers[1] ~= buf_number then
				return true
			end
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer", -- function ,
				text_align = "center", -- "left" | "right"
				separator = true,
			},
		},
		color_icons = true,
		show_buffer_icons = false,
		show_buffer_close_icons = true,
		show_buffer_default_icon = true,
		show_close_icon = true,
		show_tab_indicators = true,
		show_duplicate_prefix = true,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "thin", -- "slant" | "thick" | "thin" | { "any", "any" },
		enforce_regular_tabs = false,
		always_show_bufferline = true,
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
		sort_by = "id",
		-- |"insert_after_current",
		-- | "insert_at_end"
		-- | "id"
		-- | "extension"
		-- | "relative_directory"
		-- | "directory"
		-- | "tabs"
		-- | function(buffer_a, buffer_b)
		-- 	-- add custom logic
		-- 	return buffer_a.modified > buffer_b.modified
		-- end,
		groups = {
			options = {
				toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
			},
			separator = {
				tab = icons.ui.DoubleSeparator,
			},
			items = {
				{
					name = "Tests", -- Mandatory
					highlight = { underline = true, sp = "blue" }, -- Optional
					auto_close = true, -- whether or not close this group if it doesn't contain the current buffer
					priority = 3, -- determines where it will appear relative to other groups (Optional)
					icon = "", -- Optional
					matcher = function(buf) -- Mandatory
						return buf.filename:match("%_test") or buf.filename:match("%_spec")
					end,
				},
				{
					name = "Docs",
					highlight = { undercurl = true, sp = "green" },
					auto_close = true, -- whether or not close this group if it doesn't contain the current buffer
					priority = 2, -- determines where it will appear relative to other groups (Optional)
					icons = icons.documents.Files,
					matcher = function(buf)
						return buf.filename:match("%.md") or buf.filename:match("%.txt")
					end,
					separator = { -- Optional
						style = require("bufferline.groups").separator.tab,
					},
				},
				{
					name = "Conf",
					highlight = { undercurl = true, sp = "gray" },
					auto_close = true, -- whether or not close this group if it doesn't contain the current buffer
					matcher = function(buf)
						return buf.filename:match("%.toml")
							or buf.filename:match("%.json")
							or buf.filename:match("%.yaml")
							or buf.filename:match("%.yml")
							or buf.filename:match("%.properties")
					end,
					separator = { -- Optional
						style = require("bufferline.groups").separator.tab,
					},
				},
			},
		},
	},
})

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>p", "<cmd>BufferLinePick<CR>", opts)
keymap("n", "<leader>P", "<cmd>BufferLinePickClose<CR>", opts)
keymap("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", opts)
keymap("n", "]b", "<Cmd>BufferLineCycleNext<CR>", opts)
