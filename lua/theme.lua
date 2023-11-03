-- local colorscheme = "gruvbox-material"
-- if colorscheme == "gruvbox-material" then
--     vim.g.gruvbox_material_background = "soft"
--     vim.g.gruvbox_material_foreground = "hard"
--     vim.g.gruvbox_material_ui_contrast = "high"
--
--     vim.g.gruvbox_material_current_word = "underline"
--
--     vim.g.gruvbox_material_disable_italic_comment = 1
--     vim.g.gruvbox_material_diagnostic_text_highlight = 1
--     -- vim.g.gruvbox_material_diagnostic_line_highlight = 1
--
--     local status_ok, lualine = pcall(require, "lualine")
--     if status_ok then
--         lualine.setup({
--             options = {
--                 theme = "gruvbox-material",
--             },
--         })
--     end
-- end
-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
--     vim.notify("colorscheme " .. colorscheme .. " not Found")
--     return
-- end
-- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha"
require("catppuccin").setup({
    integrations = {
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        harpoon = true,
        lsp_saga = true
    }
})
vim.cmd.colorscheme "catppuccin-macchiato"
