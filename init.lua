require("basic")
require("config.lazy")
require("keybindings")

-- for lsp
require("lsp.mason")
require("lsp.metals")
-- require("lsp.null-ls")
require("lsp.nvim-treesitter")
-- require("lsp.luasnip")
-- require("lsp.cmp")
require("lsp.lspsaga")
require("lsp.lsp-signature")
require("lsp.trouble")
require("lsp.conform")
-- dap
require("config.dap")

-- for status/winbar
require("config.lua-line")
require("config.bufferline")

-- git
require("config.gitsigns")
-- terminal
require("config.toggleterm")
-- motion
require("config.leap")
-- comment
require("config.comment")
-- symbol viewer
-- require("config.vista")
-- mini.vim: cursor_word, pairs, ai
require("config.mini")
-- require("config.colorizer")
-- marks
require("config/marks")
-- fuzzy finder, can also integration with many plugins amazingly!
-- require("config.telescope")

