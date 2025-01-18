local vim = vim
local icons = {
	kind = require("ui.icons").get("kind", false),
	type = require("ui.icons").get("type", false),
	cmp = require("ui.icons").get("cmp", false),
}
-- vim.api.nvim_command([[packadd cmp-tabnine]])

local border = function(hl)
	return {
		{ "┌", hl },
		{ "─", hl },
		{ "┐", hl },
		{ "│", hl },
		{ "┘", hl },
		{ "─", hl },
		{ "└", hl },
		{ "│", hl },
	}
end

local cmp_window = require("cmp.utils.window")

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
	local info = self:info_()
	info.scrollable = false
	return info
end

local compare = require("cmp.config.compare")
local lspkind = require("lspkind")
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users
			-- For `luasnip` users.
			require("luasnip").lsp_expand(args.body)

			-- For `ultisnips` users.
			-- vim.fn["UltiSnips#Anon"](args.body)

			-- For `snippy` users.
			-- require'snippy'.expand_snippet(args.body)
		end,
	},
	window = {
		documentation = {
			border = border("CmpDocBorder"),
		},
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			-- require("cmp_tabnine.compare"),
			compare.offset,
			compare.exact,
			compare.score,
			require("cmp-under-comparator").under,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		},
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			lspkind.cmp_format({
				mode = "symbol",
				maxwidth = 50,
				symbol_map = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp),
			})(entry, vim_item)
			vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
			return vim_item
		end,
	},
	-- You can set mappings if you want
	mapping = cmp.mapping.preset.insert(require("keybindings").cmp_mapping(cmp)),
	-- You should specify your *installed* sources.
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "vsnip" },
		{ name = "nvim_lua" },
		-- { name = "luasnip" },
		{ name = "path" },
		-- { name = "spell" },
		-- { name = "orgmode" },
		{ name = "buffer" },
		-- { name = "latex_symbols" },
		-- { name = "cmp_tabnine" },
	},
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
