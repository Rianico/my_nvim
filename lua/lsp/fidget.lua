require("fidget").setup({
	window = { blend = 0 },
})
vim.api.nvim_set_hl(0, "FidgetTitle", { link = "Title" })
vim.api.nvim_set_hl(0, "FidgetTask", { link = "Todo" })
