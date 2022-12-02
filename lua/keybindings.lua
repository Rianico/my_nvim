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
map("n", "<C-s>", ":w<CR>", opt)
map("i", "<C-s>", "<C-o>:w<CR>", opt)
map("n", "<C-q>", ":q<CR>", opt)

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
-- map("n", "<leader>t", "v:count ? 'gt' : 'gt'", opt_expr)
-- map("n", "<leader>T", "v:count ? 'gT' : 'gT'", opt_expr)

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
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
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
	-- Enable completion triggered by <c-x><c-o>
	-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

pluginKeys.cmp_mapping = function(cmp)
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

pluginKeys.rust_tools_mapping = function(client, bufnr)
	pluginKeys.on_attach(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	local rt = require("rust-tools")
	vim.keymap.set("n", "<C-k>", rt.hover_actions.hover_actions, bufopts)
end

return pluginKeys
