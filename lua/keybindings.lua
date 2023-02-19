vim.g.mapleader = ","
vim.g.maplocalleader = ","
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- emacs style shorten
map("n", "<C-a>", "^", opt)
map("n", "<C-e>", "$", opt)
map("i", "<C-a>", "<C-o><S-i>", opt)
map("i", "<C-e>", "<C-o><S-a>", opt)
map("i", "<C-k>", "<C-o>d$", opt)
-- delete character afterward
map("i", "<C-d>", "<C-o>s", opt)

-- save and quit
map("n", "<C-s>", ":w<CR>", opt)
map("i", "<C-s>", "<Esc>:w<CR>", opt)
map("n", "<C-q>", ":confirm q<CR>", opt)

-- close current window
map("n", "<leader>q", "<C-w>c", opt)

-- vista.vim
map("n", "<leader><leader>", ":Vista!!<CR>", { noremap = true })

-- fzf.vim
map("n", "<C-p>", ":Files<CR>", opt)
map("n", "<leader>f", ":Lines<CR>", opt)
map("n", "<leader>F", ":Rg<CR>", opt)
map("n", "<leader>b", ":Buffers<CR>", opt)
vim.g.fzf_action = {
	["enter"] = "tab drop",
	["ctrl-s"] = "split",
	["ctrl-v"] = "vsplit",
}

-- Mappings.
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)

local pluginKeys = {}

-- NvimTree
map("n", "<leader>e", ":NvimTreeFindFile<CR>", opt)
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
pluginKeys.nvimTreeList = {
	-- 打开文件或件夹
	{ key = { "<CR>", "o", "<2-LeftMouse>" }, action = "tabnew" },
	{ key = "e", action = "edit" },
	-- 分屏打开文件
	{ key = "v", action = "vsplit" },
	-- 文件操作
	{ key = "a", action = "create" },
	{ key = "d", action = "remove" },
	{ key = "r", action = "rename" },
	{ key = "x", action = "cut" },
	{ key = "c", action = "copy" },
	{ key = "p", action = "paste" },
	{ key = "o", action = "system_open" },
}

pluginKeys.on_attach = function(client, bufnr)
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- finished by lspsaga
	-- vim.keymap.set("n", "<space>d", vim.lsp.buf.type_definition, bufopts)
	-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	-- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	-- vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- For cmp
pluginKeys.cmp_mapping = function(cmp)
	local has_words_before = function()
		local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end
	local M = {}
	M = {
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
				-- elseif require("luasnip").expand_or_jumpable() then
				-- 	vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn("vsnip#jumpable(-1)")[1] then
				feedkey("<Plug>(vsnip-jump-prev)", "")
				-- elseif require("luasnip").jumpable(-1) then
				-- 	vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
			else
				fallback()
			end
		end, { "i", "s" }),
	}
	return M
end

-- For rust-tools
pluginKeys.rust_tools_mapping = function(client, bufnr)
	pluginKeys.on_attach(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<Space>d", ":RustHoverAction<CR>", bufopts)
	vim.keymap.set("n", "<Space>r", require("rust-tools").runnables.runnables, bufopts)
	vim.keymap.set("n", "<Space>k", ":RustMoveItemUp<CR>", bufopts)
	vim.keymap.set("n", "<Space>j", ":RustMoveItemDown<CR>", bufopts)
	vim.keymap.set("n", "<Space>em", ":RustExpandMacro<CR>", bufopts)
	vim.keymap.set("n", "<Space>p", ":RustParentModule<CR>", bufopts)
end

-- For lspsaga
-- Finished by lspsaga
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
pluginKeys.lspsaga_mapping = function()
	local keymap = vim.keymap.set
	local bufopts = { noremap = true, silent = true }

	keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", bufopts)
	keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", bufopts)
	keymap("n", "gD", "<cmd>Lspsaga goto_definition<CR>", bufopts)
	keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>", bufopts)
	-- Outline
	keymap("n", "<Leader>o", "<cmd>Lspsaga outline<CR>", bufopts)
	-- Call hierarchy
	keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
	keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
	-- Code action
	keymap({ "n", "v" }, "<Space>ca", "<cmd>Lspsaga code_action<CR>", bufopts)

	-- Rename
	keymap("n", "<leader>r", "<cmd>Lspsaga rename ++project<CR>", bufopts)

	-- Diagnsotic jump can use `<c-o>` to jump back
	keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
	keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
	-- Only jump to error
	keymap("n", "[D", function()
		require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, bufopts)
	keymap("n", "]D", function()
		require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, bufopts)

	-- pass somc cli command into a floating terminal and execute it.
	keymap("n", "<A-d>", "<cmd>Lspsaga term_toggle gitui<CR>", bufopts)
	-- close floaterm
	keymap("t", "<A-d>", "<cmd>Lspsaga term_toggle<CR>", bufopts)
end
pluginKeys.lspsaga_finder_keys = {
	jump_to = "p",
	edit = { "o", "<CR>" },
	vsplit = "v",
	split = "s",
	tabe = "t",
	tabnew = "T",
	quit = { "q", "<ESC>" },
}
pluginKeys.lspsaga_code_action_keys = {
	-- string | table type
	quit = { "q", "<ESC>" },
	exec = "<CR>",
}
pluginKeys.lspsaga_definition_keys = {
	edit = "<Leader>e",
	vsplit = "<Leader>v",
	split = "<Leader>s",
	tabe = "<Leader>t",
	quit = "q",
}
pluginKeys.lspsaga_callhierarchy_keys = {
	edit = "e",
	vsplit = "v",
	split = "s",
	tabe = "t",
	jump = "<Tab>",
	quit = "q",
	expand_collapse = "u",
}
pluginKeys.lspsaga_diagnostic_keys = {
	exec_action = "<CR>",
	quit = "q",
	-- 跳转到 code action
	go_action = "g",
}

-- For trouble
pluginKeys.trouble_action_keys = { -- key mappings for actions in the trouble list
	-- map to {} to remove a mapping, for example:
	-- close = {}
	close = "q", -- close the list
	cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
	refresh = "r", -- manually refresh
	jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
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
	vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
end

return pluginKeys
