require("lsp_signature").setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	handler_opts = {
		border = "rounded",
	},
	max_height = 32,
	transparency = 32,
	floating_window_above_cur_line = false,
	hint_prefix = "🦀 ",
	move_cursor_key = "<C-k>",
})
