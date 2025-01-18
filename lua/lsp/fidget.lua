require("fidget").setup({
	notification = {
		window = { winblend = 0 },
	},
})

vim.notify = require("notify")

require("notify").setup({
	stages = "fade", -- Different animation style
})
-- vim.api.nvim_set_hl(0, "FidgetTitle", { link = "Title" })
-- vim.api.nvim_set_hl(0, "FidgetTask", { link = "Todo" })
