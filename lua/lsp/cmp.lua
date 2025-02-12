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
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		-- documentation = { border = border("CmpDocBorder") },
		documentation = cmp.config.window.bordered(),
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
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "nvim_lsp_signature_help" },
		{ name = "vsnip", keyword_length = 1 },
		{ name = "nvim_lua", keyword_length = 2 },
		{ name = "path", keyword_length = 2 },
		-- { name = "spell" },
		-- { name = "orgmode" },
		{ name = "buffer", keyword_length = 2 },
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
