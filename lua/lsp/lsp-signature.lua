require("lsp_signature").setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	floating_window = false,
	handler_opts = {
		border = "rounded",
	},
	floating_window_off_x = 1, -- adjust float windows x position.
	floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
	hint_prefix = "🦀 ",
})
