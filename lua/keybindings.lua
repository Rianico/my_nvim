vim.g.mapleader = ","
vim.g.maplocalleader = ","

local map = vim.keymap.set
local opt = { noremap = true, silent = true }

-- local feedkey = function(key, mode)
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
-- end

-- emacs style shorten
map("n", "<C-a>", "^", opt)
map("n", "<C-e>", "$", opt)
map("i", "<C-a>", "<C-o><S-i>", opt)
map("i", "<C-e>", "<C-o><S-a>", opt)
-- delete character afterward
map("i", "<C-d>", "<C-o>s", opt)
-- save and quit
map("n", "<C-s>", ":w<CR>", opt)
map("i", "<C-s>", "<Esc>:w<CR>", opt)
map("n", "<C-q>", ":confirm q<CR>", opt)

--terminal
map("t", "<esc>", [[<C-n>]], opt)

-- window
-- <C-w>x, exchange with other window
-- <C-w>r, rotate current window
map({ "t", "n" }, "<C-h>", [[<Cmd>wincmd h<CR>]], opt)
map({ "t", "n" }, "<C-j>", [[<Cmd>wincmd j<CR>]], opt)
map({ "t", "n" }, "<C-k>", [[<Cmd>wincmd k<CR>]], opt)
map({ "t", "n" }, "<C-l>", [[<Cmd>wincmd l<CR>]], opt)

-- vista.vim
map("n", "<Leader><Leader>", ":Vista!!<CR>", { noremap = true })

-- bufferline
map("n", ";1", "<Cmd>BufferLineGoToBuffer 1<CR>", opt)
map("n", ";2", "<Cmd>BufferLineGoToBuffer 2<CR>", opt)
map("n", ";3", "<Cmd>BufferLineGoToBuffer 3<CR>", opt)
map("n", ";4", "<Cmd>BufferLineGoToBuffer 4<CR>", opt)
map("n", ";5", "<Cmd>BufferLineGoToBuffer 5<CR>", opt)
map("n", ";6", "<Cmd>BufferLineGoToBuffer 6<CR>", opt)
map("n", ";7", "<Cmd>BufferLineGoToBuffer 7<CR>", opt)
map("n", ";8", "<Cmd>BufferLineGoToBuffer 8<CR>", opt)
map("n", "[t", "<Cmd>BufferLineCyclePrev<CR>", opt)
map("n", "]t", "<Cmd>BufferLineCycleNext<CR>", opt)

-- local search
map("n", "<C-n>", "<Cmd>noh<CR>", opt)

local wk = require("which-key")
wk.setup({
	win = {
		border = "none", -- none, single, double, shadow
		-- position = "bottom", -- bottom, top
	},
})
-- local wk_opts = {
-- 	mode = "n", -- NORMAL mode
-- 	-- prefix: use "<Leader>f" for example for mapping everything related to finding files
-- 	-- the prefix is prepended to every mapping part of `mappings`
-- 	prefix = "",
-- 	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
-- 	silent = true, -- use `silent` when creating keymaps
-- 	noremap = true, -- use `noremap` when creating keymaps
-- 	nowait = false, -- use `nowait` when creating keymaps
-- }

-- telescope
map("n", "<C-p>", "<Cmd>Telescope find_files<CR>", opt)
map("n", "<C-S-p>", "<Cmd>Telescope commands<CR>", opt)
-- :buffers
map("n", "<Leader>b", "<Cmd>Telescope buffers<CR>", opt)

-- Zen Mode
map("n", "<Leader>z", "<Cmd>ZenMode<CR>", opt)

wk.register({
	-- registers
	-- listrregisters:
	--   normal mode: "
	--   insert mode: <C-r>
	["<Leader>r"] = {
		name = "Registers",
		r = { "<Cmd>Telescope neoclip<CR>", "Neoclip" },
		t = { "<Cmd>Telescope registers<CR>", "Telescope Registers" },
	},

	-- telescope
	["<Leader>f"] = {
		name = "Files",
		f = { "<Cmd>Telescope current_buffer_fuzzy_find<CR>", "Grep Current Buffer" },
		g = { "<Cmd>Telescope live_grep<CR>", "Live Grep" },
		s = { "<cmd>Telescope grep_string<CR>", "Grep String" },
		e = { "<Cmd>Telescope file_browser<CR>", "File Browser" },
		E = { ":lua MiniFiles.open()<CR>", "File Explorer" },
		-- <C-q> Send all items not filtered to quickfixlist (qflist)
		-- M-q Send all selected items to qflist
	},

	-- harpoon
	["<Leader>h"] = {
		name = "Harpoon",
		h = { "<Cmd>lua require('harpoon.mark').add_file()<CR>", "Add File To Quick Menu" },
		t = { "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toogle Quick Menu" },
		T = { "<Cmd>Telescope harpoon marks<CR>", "Telescope Quick Menu" },
	},

	-- marks
	["<Leader>m"] = {
		name = "Marks",
		-- list marks: ' in normal mode
		d = { "<Plug>(Marks-delete)", "Delete Marks Input: <input>" },
		l = { "<Plug>(Marks-deleteline)", "Delete Marks In Current Line" },
		D = { "<Plug>(Marks-deletebuf)", "Delete Marks In Current Buffer" },
		A = { "<Cmd>delmarks a-zA-Z0-9<CR>", "Delete All Marks" },
		b = { "<Cmd>MarksListBuf<CR>", "Buffer Marks" },
		m = { "<Cmd>Telescope marks<CR>", "Telescope Marks" },
	},
	["m"] = {
		name = "Marks",
		m = { "<Plug>(Marks-setnext)", "Marks SetNext" },
	},

	-- leap
	["<Leader>s"] = {
		name = "Leap",
		-- s<space><space> jump to the line
		s = { "<Plug>(leap-forward)", "Leap Forward", modes = { "n", "x", "o" } },
		S = { "<Plug>(leap-backward)", "Leap Backward", modes = { "n", "x", "o" } },
		g = { "<Plug>(leap-from-window)", "Leap Across Window", modes = { "n" } },
	},

	-- gitsigns
	["<Leader>g"] = {
		name = "Gits",
		s = { "<Cmd>Gitsigns stage_hunk<CR>", "Stage Hunk" },
		r = { "<Cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },

		u = { "<Cmd>Gitsigns undo_stage_hunk<CR>", "Unstage Hunk" },

		S = { "<Cmd>Gitsigns stage_buffer<CR>", "Stage Buffer" },
		R = { "<Cmd>Gitsigns reset_buffer<CR>", "Reset Buffer" },

		d = { "<Cmd>Gitsigns toggle_deleted<CR>", "Toggle Deleted" },
		D = { "<Cmd>Gitsigns diffthis<CR>", "Diff" },

		l = { "<Cmd>Gitsigns toggle_current_line_blame<CR>", "Line Blame" },
		p = { "<Cmd>Gitsigns preview_hunk<CR>", "Preview Hunk" },

		c = { "<Cmd>Gitsigns toggle_signs<CR>", "Sign Column" },
		h = { "<Cmd>Gitsigns toggle_linehl<CR>", "Toggle Linehl" },

		g = {
			"<Cmd>lua require('toggleterm.terminal').Terminal:new({ cmd = 'gitui', hidden = true, count = 9, direction = 'tab' }):toggle()<CR>",
			"Gitui",
		},
	},

	-- toggleterm
	["<Leader>t"] = {
		name = "ToggleTerm",
		-- <C-\> ToggleTerm
		t = { "<Cmd>ToggleTerm direction=horizontal<CR>", "Horizontal Terminal" },
		v = { "<Cmd>ToggleTerm direction=vertical<CR>", "Vertical VTerminal" },
	},
})

-- gitsigns
local gs = require("gitsigns")
map("n", "]c", function()
	if vim.wo.diff then
		return "]c"
	end
	vim.schedule(function()
		gs.next_hunk()
	end)
	return "<Ignore>"
end, { expr = true })
map("n", "[c", function()
	if vim.wo.diff then
		return "[c"
	end
	vim.schedule(function()
		gs.prev_hunk()
	end)
	return "<Ignore>"
end, { expr = true })

local pluginKeys = {}
-- general lsp keybindings based on vim.lsp
pluginKeys.default_on_attach = function(client, bufnr)
	wk.add({
		mod = "n",
		{
			"gi",
			vim.lsp.buf.implementation,
			desc = "Go to the implementation",
		},
		{ "<Space>w", group = "Workspace" },
		{ "<space>wa", vim.lsp.buf.add_workspace_folder, desc = "Workspace Add Folder" },
		{ "<space>wr", vim.lsp.buf.remove_workspace_folder, desc = "Workspace Remove Folder" },
		{
			"<space>wl",
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			desc = "Workspace List",
		},
		{
			"<space>f",
			function()
				vim.lsp.buf.format({ async = true, bufnr = bufnr })
			end,
			desc = "Lsp Buffer Format",
		},
	})
end

pluginKeys.rustaceanvim = function(client, bufnr)
	pluginKeys.default_on_attach(client, bufnr)
	wk.add({
		mod = "n",
		{ "<Space>r", group = "Rust" },
		{ "<Space>rh", ":RustLsp hover actions<CR>", desc = "Rust Hover Action" },
		{ "<Space>re", ":RustLsp expandMacro<CR>", desc = "Rust Expand Macro" },
		{ "<Space>rp", ":RustLsp parentModule<CR>", desc = "Rust Parent Module" },
	})
end

pluginKeys.dap_mapping = function(dap, dapui)
	wk.add({
		mod = "n",
		{ "<space>d", group = "Dap" },
		{ "<space>db", dap.toggle_breakpoint, desc = "Dap Toggle Breakpoint" },
		{ "<space>dl", dap.list_breakpoints, desc = "Dap List Breakpoints" },
		{ "<space>dC", dap.run_to_cursor, desc = "Dap Run To Cursor" },
		{ "<space>dc", dap.continue, desc = "Dap Continue" },
		{ "<f7>", dap.step_into, desc = "Dap Step Into" },
		{ "<f8>", dap.step_over, desc = "Dap Step Over" },
		{ "<f20>", dap.step_out, desc = "Dap Step Out" },
		{ "<space>dr", dap.restart, desc = "Dap Restart" },
		{ "<space>dx", dap.terminate, desc = "Dap Terminated" },
		{
			"<space>de",
			function()
				dapui.eval(nil, { enter = true })
			end,
			desc = "Dap Eval Value",
		},
	})
	-- map("n", "<space>db", dap.toggle_breakpoint, { desc = "" }, opt)
	-- Eval var under cursor
end

-- For LSP
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opt)
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
pluginKeys.lspsaga_mapping = function()
	wk.add({
		mod = "n",
		{ "gf", "<Cmd>Lspsaga finder<CR>", desc = "Code Action: Find ref" },
		{
			"gd",
			"<Cmd>Lspsaga peek_definition<CR>",
			desc = "Code Actions: Definition",
		},
		{ "gD", "<Cmd>Lspsaga goto_type_definition<CR>", desc = "Code Actions: Type Definition" },
		{ "gr", "<Cmd>Lspsaga rename ++project<CR>", desc = "Code Actions: Rename" },
		{ "<Space>l", group = "Lsp" },
		{ "<Space>ll", "<cmd>Lspsaga code_action<CR>", desc = "code actions" },
		{ "<Space>ls", "<cmd>Lspsaga outline<CR>", desc = "code outline" },
		{ "<Space>li", "<cmd>Telescope lsp_incoming_calls<CR>", desc = "incoming calls" },
		{ "<Space>lo", "<cmd>Telescope lsp_outgoing_calls<CR>", desc = "outgoing calls" },
		{ "<Space>lk", "<cmd>Lspsaga hover_doc ++keep<CR>", desc = "hover docs" },
		{ "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "jump to prev diagnostic" },
		{ "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", desc = "jump to next diagnostic" },
		{
			"[D",
			function()
				require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end,
			desc = "jump to prev error",
		},
		{
			"]D",
			function()
				require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
			end,
			desc = "jump to next error",
		},
	})
end
pluginKeys.lspsaga_finder_keys = {
	shuttle = "[w",
	toggle_or_open = { "e", "<CR>" },
	vsplit = "v",
	split = "s",
	tabe = "t",
	tabnew = "T",
	quit = "q",
	close = "<ESC>",
}
pluginKeys.lspsaga_code_action_keys = {
	-- string | table type
	quit = { "q", "<ESC>" },
	exec = "<CR>",
}
pluginKeys.lspsaga_definition_keys = {
	edit = { "e", "<CR>" },
	vsplit = "v",
	split = "s",
	tabe = "t",
	quit = "q",
}
pluginKeys.lspsaga_callhierarchy_keys = {
	edit = { "e", "<CR>" },
	vsplit = "v",
	split = "s",
	tabe = "t",
	quit = "q",
	shuttle = "[w",
	toggle_or_req = "u",
	close = "<ESC>",
}
pluginKeys.lspsaga_diagnostic_keys = {
	exec_action = "<CR>",
	quit = { "q", "<ESC>" },
}
pluginKeys.lspsaga_rename_keys = {
	exec = "<CR>",
	quit = "<ESC>",
}

-- For cmp
pluginKeys.cmp_mapping = function(cmp)
	-- local has_words_before = function()
	-- 	local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
	-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	-- end
	local ls = require("luasnip")
	return {
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-l>"] = cmp.mapping(function(_)
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-j>"] = cmp.mapping(function(_)
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { "i", "s" }),
	}
end

-- For trouble
pluginKeys.trouble_action_keys = {
	-- key mappings for actions in the trouble list
	-- map to {} to remove a mapping, for example:
	-- close = {}
	close = "q", -- close the list
	cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
	refresh = "r", -- manually refresh
	jump = { "<CR>", "<tab>" }, -- jump to the diagnostic or open / close folds
	open_split = { "<c-s>" }, -- open buffer in new split
	open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
	open_tab = { "<c-t>" }, -- open buffer in new tab
	jump_close = { "o" }, -- jump to the diagnostic and close the list
	toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
	toggle_preview = "P", -- toggle auto_preview
	hover = "K", -- opens a small popup with the full multiline message
	preview = "p", -- preview the diagnostic location
	close_folds = { "Z" }, -- close all folds
	open_folds = { "z" }, -- open all folds
	toggle_fold = { "zA", "za" }, -- toggle fold of current file
	previous = "k", -- previous item
	next = "j", -- next item
}
pluginKeys.trouble_mapping = function()
	-- Lua
	wk.add({
		mode = "n",
		name = "Trouble",
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	})
end

return pluginKeys
