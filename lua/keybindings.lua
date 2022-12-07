vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- emacs style shorten
map("n", "<C-a>", "^", opt)
map("n", "<C-e>", "$", opt)
map("i", "<C-a>", "<C-o><S-i>", opt)
map("i", "<C-e>", "<C-o><S-a>", opt)
map("i", "<C-k>", "<C-o>d$", opt)

-- save and quit
map("n", "<C-s>", ":update<CR>", opt)
map("i", "<C-s>", "<Esc>:update<CR>", opt)
map("n", "<C-q>", ":confirm q<CR>", opt)

-- close current window
map("n", "<leader>x", "<C-w>c", opt)
-- tab switch
map("n", "<leader>t", "gt", opt)
map("n", "<leader>T", "gT", opt)
map("n", "<leader>1", "1gt<ct>", opt)
map("n", "<leader>2", "2gt<ct>", opt)
map("n", "<leader>3", "3gt<ct>", opt)
map("n", "<leader>4", "4gt<ct>", opt)
map("n", "<leader>5", "5gt<ct>", opt)
map("n", "<leader>6", "6gt<ct>", opt)
map("n", "<leader>7", "7gt<ct>", opt)
map("n", "<leader>8", "8gt<ct>", opt)

-- hop.nvim
map("n", "<leader>w", ":HopWord<CR>", opt)
map("n", "<leader>l", ":HopLineStart<CR>", opt)
map("n", "<leader>p", ":HopPattern<CR>", opt)

-- vista.vim
map("n", "<leader>\\", ":Vista!!<CR>", { noremap = true })

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
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
-- Finished by lspsaga
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

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
	{ key = "s", action = "vsplit" },
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
	-- Enable nvim-navic
	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- finished by lspsaga
	-- vim.keymap.set("n", "<space>d", vim.lsp.buf.type_definition, bufopts)
	-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	-- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	-- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
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
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
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
	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end
	pluginKeys.on_attach(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<Space>d", ":RustHoverAction<CR>", bufopts)
	vim.keymap.set("n", "<Leader>r", require("rust-tools").runnables.runnables, bufopts)
	vim.keymap.set("n", "<Space>k", ":RustMoveItemUp<CR>", bufopts)
	vim.keymap.set("n", "<Space>j", ":RustMoveItemDown<CR>", bufopts)
	vim.keymap.set("n", "<Space>em", ":RustExpandMacro<CR>", bufopts)
	vim.keymap.set("n", "<Space>p", ":RustParentModule<CR>", bufopts)
end

-- For lspsaga
pluginKeys.lspsaga_mapping = function()
	local keymap = vim.keymap.set
	local bufopts = { noremap = true, silent = true }

	keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", bufopts)
	keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", bufopts)
	keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", bufopts)
	-- Code action
	keymap({ "n", "v" }, "<Space>ca", "<cmd>Lspsaga code_action<CR>", bufopts)

	-- Rename
	keymap("n", "<Space>r", "<cmd>Lspsaga rename<CR>", bufopts)

	-- Diagnsotic jump can use `<c-o>` to jump back
	keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
	keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
	-- Only jump to error
	keymap("n", "[D", function()
		require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, bufopts)
	keymap("n", "]D", function()
		require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, bufopts)

	-- pass somc cli command into a floating terminal and execute it.
	keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm gitui<CR>", bufopts)
	-- close floaterm
	keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], bufopts)

	-- Outline
	keymap("n", "<Leader>o", "<cmd>LSoutlineToggle<CR>", bufopts)
end

-- For trouble
pluginKeys.trouble_action_keys = { -- key mappings for actions in the trouble list
	-- map to {} to remove a mapping, for example:
	-- close = {},
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
	vim.keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
end

return pluginKeys
