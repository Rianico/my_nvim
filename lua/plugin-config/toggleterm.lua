require("toggleterm").setup({
	-- If you prefix the mapping with a number that particular terminal will be opened. Otherwise if a prefix is not set, then the last toggled terminal will be opened.
	size = function(term)
		if term.direction == "horizontal" then
			return vim.o.lines * 0.32
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.5
		end
	end,
	open_mapping = [[<c-\>]],
	hide_numbers = false,
	autochdir = true,
	direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float',
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		-- The border key is *almost* the same as 'nvim_open_win'
		-- see :h nvim_open_win for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
		-- like `size`, width and height can be a number or function which is passed the current terminal
		winblend = 32,
	},
	persist_size = false,
	winbar = {
		enabled = true,
		name_formatter = function(term) --  term: Terminal
			return term.name
		end,
	},
})
