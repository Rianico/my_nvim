require("impatient")
vim.opt.termguicolors = true
vim.opt.mousemoveevent = true
local icons = {
    ui = require("ui.icons").get("ui", true),
    documents = require("ui.icons").get("documents", true),
    diagnostics = require("ui.icons").get("diagnostics", true),
}

require("bufferline").setup({
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
    options = {
        mode = "tabs", -- set to "tabs" to only show tabpages instead
        numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        indicator = {
            icon = "▎", -- this should be omitted if indicator style is not 'icon'
            style = "icon", -- 'icon' | 'none',
        },
        buffer_close_icon = icons.ui.Close,
        modified_icon = icons.ui.Modified_alt,
        close_icon = icons.ui.Close_alt,
        left_trunc_marker = icons.ui.Left,
        right_trunc_marker = icons.ui.Right,
        -- max_name_length = 18,
        -- max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = false, -- whether or not tab names should be truncated
        -- tab_size = 18,
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        show_buffer_icons = false, -- disable filetype icons for buffers
        show_buffer_close_icons = false,
        -- show_buffer_default_icon = false, -- whether or not an unrecognised filetype should show a default icon
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
        separator_style = "thin",     -- "slant" | "slope" | "thick" | "thin" | { "any", "any" },
        hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
        },
        sort_by = "id",
        -- |"insert_after_current",
        -- | "insert_at_end"
        -- | "id"
        -- | "extension"
        -- | "relative_directory"
        -- | "directory"
        -- | "tabs"
        -- | function(buffer_a, buffer_b)
        -- 	-- add custom logic
        -- 	return buffer_a.modified > buffer_b.modified
        -- end,
        groups = {
            options = {
                toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
            },
            separator = {
                tab = icons.ui.DoubleSeparator,
            },
            items = {
                {
                    name = "Tests", -- Mandatory
                    highlight = { underline = true, sp = "blue" }, -- Optional
                    auto_close = true, -- whether or not close this group if it doesn't contain the current buffer
                    priority = 3, -- determines where it will appear relative to other groups (Optional)
                    icon = "", -- Optional
                    matcher = function(buf) -- Mandatory
                        return buf.filename:match("%_test") or buf.filename:match("%_spec")
                    end,
                },
                {
                    name = "Docs",
                    highlight = { undercurl = true, sp = "green" },
                    auto_close = true, -- whether or not close this group if it doesn't contain the current buffer
                    priority = 2,      -- determines where it will appear relative to other groups (Optional)
                    icons = icons.documents.Files,
                    matcher = function(buf)
                        return buf.filename:match("%.md") or buf.filename:match("%.txt")
                    end,
                    separator = { -- Optional
                        style = require("bufferline.groups").separator.tab,
                    },
                },
                {
                    name = "Conf",
                    highlight = { undercurl = true, sp = "gray" },
                    auto_close = true, -- whether or not close this group if it doesn't contain the current buffer
                    matcher = function(buf)
                        return buf.filename:match("%.toml")
                            or buf.filename:match("%.json")
                            or buf.filename:match("%.yaml")
                            or buf.filename:match("%.yml")
                            or buf.filename:match("%.properties")
                    end,
                    separator = { -- Optional
                        style = require("bufferline.groups").separator.tab,
                    },
                },
            },
        },
    },
})
