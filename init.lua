require("basic")
require("config.lazy")
require("keybindings")
require("theme")

-- for lsp
require("lsp.mason")
require("lsp.metals")
require("lsp.null-ls")
require("lsp.nvim-treesitter")
require("lsp.luasnip")
require("lsp.cmp")
require("lsp.lspsaga")
require("lsp.lsp-signature")
require("lsp.trouble")
-- dap
require("config.dap")

-- beautify
require("config.noice")

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
require("config.vista")
-- mini.vim: cursor_word, pairs, ai
require("config.mini")
require("config.colorizer")
-- marks
require("config/marks")
-- neoclip, manage your registers
require("config/neoclip")
-- fuzzy finder, can also integration with many plugins amazingly!
require("config.telescope")
require("config.ai-code")
