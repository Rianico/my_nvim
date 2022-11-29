-- vim.g.vista_sidebar_width = 40
-- How each level is indented and what to prepend.
-- This could make the display more compact or more spacious.
-- e.g., more compact: ["▸ ", ""]
-- Note: this option only works for the kind renderer, not the tree renderer.
vim.g.vista_icon_indent = { "╰─▸ ", "├─▸ " }

-- Executive used when opening vista sidebar without specifying it.
-- See all the avaliable executives via `:echo g:vista#executives`.
vim.g.vista_default_executive = "nvim_lsp"

vim.g.vista_echo_cursor_strategy = "floating_win"
vim.g.vista_sidebar_width = 50
vim.g.vista_close_on_jump = 1
