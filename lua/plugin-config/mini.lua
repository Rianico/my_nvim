require("mini.cursorword").setup()

require("mini.pairs").setup({
	-- In which modes mappings from this `config` should be created
	modes = { insert = true, command = false, terminal = false },

	-- Global mappings. Each right hand side should be a pair information, a
	-- table with at least these fields (see more in |MiniPairs.map|):
	-- - <action> - one of 'open', 'close', 'closeopen'.
	-- - <pair> - two character string for pair to be used.
	-- By default pair is not inserted after `\`, quotes are not recognized by
	-- `<CR>`, `'` does not insert pair after a letter.
	-- Only parts of tables can be tweaked (others will use these defaults).
	mappings = {
		["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
		["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
		["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

		[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
		["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
		["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

		['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
		["<"] = { action = "closeopen", pair = "<>", neigh_pattern = "[^ \\].", register = { cr = false } },
		["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
		-- for rust's lifetime
		["'"] = { action = "close", pair = "''", neigh_pattern = "[^<\\].", register = { cr = false } },
	},
})

require("mini.ai").setup({
	-- Table with textobject id as fields, textobject specification as values.
	-- Also use this to disable builtin textobjects. See |MiniAi.config|.
	custom_textobjects = nil,

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		-- Main textobject prefixes
		around = "a",
		inside = "i",

		-- Next/last variants
		around_next = "an",
		inside_next = "in",
		around_last = "al",
		inside_last = "il",

		-- Move cursor to corresponding edge of `a` textobject
		goto_left = "g[",
		goto_right = "g]",
	},

	-- Number of lines within which textobject is searched
	n_lines = 50,

	-- How to search for object (first inside current line, then inside
	-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
	-- 'cover_or_nearest', 'next', 'previous', 'nearest'.
	search_method = "cover_or_next",
})
