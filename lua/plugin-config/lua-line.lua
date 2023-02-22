local icons = {
    diagnostics = require("ui.icons").get("diagnostics", true),
    ui = require("ui.icons").get("ui", true),
}

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = icons.ui.Separator, right = "" },
        section_separators = { left = icons.ui.Separator, right = "" },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            "os.date('%H:%M')",
            "branch",
            "diff",
            {
                "diagnostics",
                symbols = {
                    error = icons.diagnostics.Error_alt,
                    warn = icons.diagnostics.Warning,
                    info = icons.diagnostics.Information,
                    hint = icons.diagnostics.Hint_alt,
                },
            },
        },
        lualine_c = { { "filename", file_status = true, path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "location" },
        lualine_z = { "progress" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename", "diff" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        -- lualine_a = {
        -- 	{
        -- 		"tabs",
        -- 		max_length = vim.o.columns / 3,
        -- 		mode = 2,
        -- 	},
        -- },
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {
        "quickfix",
        "nvim-tree",
        "nvim-dap-ui",
        "symbols-outline",
    },
})
