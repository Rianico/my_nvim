local config = {}

function config.alpha()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⣠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣡⣾⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣟⠻⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⡿⢫⣷⣿⣿⣿⣿⣿⣿⣿⣾⣯⣿⡿⢧⡚⢷⣌⣽⣿⣿⣿⣿⣿⣶⡌⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣇⣘⠿⢹⣿⣿⣿⣿⣿⣻⢿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⡟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣻⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⡇⠀⣬⠏⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣷⣼⣿⣿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⠀⠈⠁⠀⣿⡇⠘⡟⣿⣿⣿⣿⣿⣿⣿⣿⡏⠿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⡏⠀⠀⠐⠀⢻⣇⠀⠀⠹⣿⣿⣿⣿⣿⣿⣩⡶⠼⠟⠻⠞⣿⡈⠻⣟⢻⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢿⠀⡆⠀⠘⢿⢻⡿⣿⣧⣷⢣⣶⡃⢀⣾⡆⡋⣧⠙⢿⣿⣿⣟⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⡥⠂⡐⠀⠁⠑⣾⣿⣿⣾⣿⣿⣿⡿⣷⣷⣿⣧⣾⣿⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⡿⣿⣍⡴⠆⠀⠀⠀⠀⠀⠀⠀⠀⣼⣄⣀⣷⡄⣙⢿⣿⣿⣿⣿⣯⣶⣿⣿⢟⣾⣿⣿⢡⣿⣿⣿⣿⣿]],
        [[⣿⡏⣾⣿⣿⣿⣷⣦⠀⠀⠀⢀⡀⠀⠀⠠⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣡⣾⣿⣿⢏⣾⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⣿⣿⣿⣿⣿⡴⠀⠀⠀⠀⠀⠠⠀⠰⣿⣿⣿⣷⣿⠿⠿⣿⣿⣭⡶⣫⠔⢻⢿⢇⣾⣿⣿⣿⣿⣿⣿]],
        [[⣿⣿⣿⡿⢫⣽⠟⣋⠀⠀⠀⠀⣶⣦⠀⠀⠀⠈⠻⣿⣿⣿⣾⣿⣿⣿⣿⡿⣣⣿⣿⢸⣾⣿⣿⣿⣿⣿⣿⣿]],
        [[⡿⠛⣹⣶⣶⣶⣾⣿⣷⣦⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠉⠛⠻⢿⣿⡿⠫⠾⠿⠋⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⡆⣠⢀⣴⣏⡀⠀⠀⠀⠉⠀⠀⢀⣠⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⠿⠛⠛⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣯⣟⠷⢷⣿⡿⠋⠀⠀⠀⠀⣵⡀⢠⡿⠋⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⢿⣿⣿⠂⠀⠀⠀⠀⠀⢀⣽⣿⣿⣿⣿⣿⣿⣿⣍⠛⠿⣿⣿⣿⣿⣿⣿]],
    }
    dashboard.section.header.opts.hl = "Type"

    local function button(sc, txt, leader_txt, keybind, keybind_opts)
        local sc_after = sc:gsub("%s", ""):gsub(leader_txt, "<Leader>")

        local opts = {
            position = "center",
            shortcut = sc,
            cursor = 5,
            width = 50,
            align_shortcut = "right",
            hl_shortcut = "Keyword",
        }

        if nil == keybind then
            keybind = sc_after
        end
        keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_after, keybind, keybind_opts }

        local function on_press()
            -- local key = vim.api.nvim_replace_termcodes(keybind .. '<Ignore>', true, false, true)
            local key = vim.api.nvim_replace_termcodes(sc_after .. "<Ignore>", true, false, true)
            vim.api.nvim_feedkeys(key, "t", false)
        end

        return {
            type = "button",
            val = txt,
            on_press = on_press,
            opts = opts,
        }
    end

    local leader = " "
    dashboard.section.buttons.val = {
        button("space s c", " Scheme change", leader, "<Cmd>Telescope colorscheme<CR>"),
        button("space f r", " File frecency", leader, "<Cmd>Telescope frecency<CR>"),
        button("space f e", " File history", leader, "<Cmd>Telescope oldfiles<CR>"),
        button("space f p", " Project find", leader, "<Cmd>Telescope project<CR>"),
        button("space f f", " File find", leader, "<Cmd>Telescope find_files<CR>"),
        button("space f n", " File new", leader, "<Cmd>enew<CR>"),
        button("space f w", " Word find", leader, "<Cmd>Telescope live_grep<CR>"),
    }
    dashboard.section.buttons.opts.hl = "String"

    local function footer()
        local total_plugins = #vim.tbl_keys(packer_plugins)
        return "   Have Fun with neovim"
            .. "   v"
            .. vim.version().major
            .. "."
            .. vim.version().minor
            .. "."
            .. vim.version().patch
            .. "   "
            .. total_plugins
            .. " plugins"
    end

    dashboard.section.footer.val = footer()
    dashboard.section.footer.opts.hl = "Function"

    local head_butt_padding = 2
    local occu_height = #dashboard.section.header.val + 2 * #dashboard.section.buttons.val + head_butt_padding
    local header_padding = math.max(0, math.ceil((vim.fn.winheight("$") - occu_height) * 0.25))
    local foot_butt_padding = 1

    dashboard.config.layout = {
        { type = "padding", val = header_padding },
        dashboard.section.header,
        { type = "padding", val = head_butt_padding },
        dashboard.section.buttons,
        { type = "padding", val = foot_butt_padding },
        dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)
end

function config.edge()
    vim.g.edge_style = "aura"
    vim.g.edge_enable_italic = 1
    vim.g.edge_disable_italic_comment = 1
    vim.g.edge_show_eob = 1
    vim.g.edge_better_performance = 1
    vim.g.edge_transparent_background = 1
end

function config.nord()
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_cursorline_transparent = true
    vim.g.nord_disable_background = false
    vim.g.nord_enable_sidebar_background = true
    vim.g.nord_italic = true
end

function config.catppuccin()
    require("catppuccin").setup({
        flavour = "mocha", -- Can be one of: latte, frappe, macchiato, mocha
        background = { light = "latte", dark = "mocha" },
        dim_inactive = {
            enabled = false,
            -- Dim inactive splits/windows/buffers.
            -- NOT recommended if you use old palette (a.k.a., mocha).
            shade = "dark",
            percentage = 0.15,
        },
        transparent_background = false,
        term_colors = true,
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        styles = {
            comments = { "italic" },
            properties = { "italic" },
            functions = { "italic", "bold" },
            keywords = { "italic" },
            operators = { "bold" },
            conditionals = { "bold" },
            loops = { "bold" },
            booleans = { "bold", "italic" },
            numbers = {},
            types = {},
            strings = {},
            variables = {},
        },
        integrations = {
            treesitter = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
            lsp_trouble = true,
            lsp_saga = true,
            gitgutter = false,
            gitsigns = true,
            telescope = true,
            nvimtree = true,
            which_key = true,
            indent_blankline = { enabled = true, colored_indent_levels = false },
            dashboard = true,
            neogit = false,
            vim_sneak = false,
            fern = false,
            barbar = false,
            markdown = true,
            lightspeed = false,
            ts_rainbow = true,
            mason = true,
            neotest = false,
            noice = false,
            hop = true,
            illuminate = true,
            cmp = true,
            dap = { enabled = true, enable_ui = true },
            notify = true,
            symbols_outline = false,
            coc_nvim = false,
            leap = false,
            neotree = { enabled = false, show_root = true, transparent_panel = false },
            telekasten = false,
            mini = false,
            aerial = false,
            vimwiki = true,
            beacon = false,
            navic = { enabled = false },
            overseer = false,
            fidget = true,
        },
        color_overrides = {
            mocha = {
                rosewater = "#F5E0DC",
                flamingo = "#F2CDCD",
                mauve = "#DDB6F2",
                pink = "#F5C2E7",
                red = "#F28FAD",
                maroon = "#E8A2AF",
                peach = "#F8BD96",
                yellow = "#FAE3B0",
                green = "#ABE9B3",
                blue = "#96CDFB",
                sky = "#89DCEB",
                teal = "#B5E8E0",
                lavender = "#C9CBFF",

                text = "#D9E0EE",
                subtext1 = "#BAC2DE",
                subtext0 = "#A6ADC8",
                overlay2 = "#C3BAC6",
                overlay1 = "#988BA2",
                overlay0 = "#6E6C7E",
                surface2 = "#6E6C7E",
                surface1 = "#575268",
                surface0 = "#302D41",

                base = "#1E1E2E",
                mantle = "#1A1826",
                crust = "#161320",
            },
        },
        highlight_overrides = {
            mocha = function(cp)
                return {
                    -- For base configs.
                    CursorLineNr = { fg = cp.green },
                    Search = { bg = cp.surface1, fg = cp.pink, style = { "bold" } },
                    IncSearch = { bg = cp.pink, fg = cp.surface1 },
                    Keyword = { fg = cp.pink },
                    Type = { fg = cp.blue },
                    Typedef = { fg = cp.yellow },

                    -- For native lsp configs.
                    DiagnosticVirtualTextError = { bg = cp.none },
                    DiagnosticVirtualTextWarn = { bg = cp.none },
                    DiagnosticVirtualTextInfo = { bg = cp.none },
                    DiagnosticVirtualTextHint = { fg = cp.rosewater, bg = cp.none },

                    DiagnosticHint = { fg = cp.rosewater },
                    LspDiagnosticsDefaultHint = { fg = cp.rosewater },
                    LspDiagnosticsHint = { fg = cp.rosewater },
                    LspDiagnosticsVirtualTextHint = { fg = cp.rosewater },
                    LspDiagnosticsUnderlineHint = { sp = cp.rosewater },

                    -- For treesitter.
                    ["@field"] = { fg = cp.rosewater },
                    ["@property"] = { fg = cp.yellow },

                    ["@include"] = { fg = cp.teal },
                    -- ["@operator"] = { fg = cp.sky },
                    ["@keyword.operator"] = { fg = cp.sky },
                    ["@punctuation.special"] = { fg = cp.maroon },

                    -- ["@float"] = { fg = cp.peach },
                    -- ["@number"] = { fg = cp.peach },
                    -- ["@boolean"] = { fg = cp.peach },

                    ["@constructor"] = { fg = cp.lavender },
                    -- ["@constant"] = { fg = cp.peach },
                    -- ["@conditional"] = { fg = cp.mauve },
                    -- ["@repeat"] = { fg = cp.mauve },
                    ["@exception"] = { fg = cp.peach },

                    ["@constant.builtin"] = { fg = cp.lavender },
                    -- ["@function.builtin"] = { fg = cp.peach, style = { "italic" } },
                    -- ["@type.builtin"] = { fg = cp.yellow, style = { "italic" } },
                    ["@variable.builtin"] = { fg = cp.red, style = { "italic" } },

                    -- ["@function"] = { fg = cp.blue },
                    ["@function.macro"] = { fg = cp.red, style = {} },
                    ["@parameter"] = { fg = cp.rosewater },
                    ["@keyword"] = { fg = cp.red, style = { "italic" } },
                    ["@keyword.function"] = { fg = cp.maroon },
                    ["@keyword.return"] = { fg = cp.pink, style = {} },

                    -- ["@text.note"] = { fg = cp.base, bg = cp.blue },
                    -- ["@text.warning"] = { fg = cp.base, bg = cp.yellow },
                    -- ["@text.danger"] = { fg = cp.base, bg = cp.red },
                    -- ["@constant.macro"] = { fg = cp.mauve },

                    -- ["@label"] = { fg = cp.blue },
                    ["@method"] = { style = { "italic" } },
                    ["@namespace"] = { fg = cp.rosewater, style = {} },

                    ["@punctuation.delimiter"] = { fg = cp.teal },
                    ["@punctuation.bracket"] = { fg = cp.overlay2 },
                    -- ["@string"] = { fg = cp.green },
                    -- ["@string.regex"] = { fg = cp.peach },
                    ["@type"] = { fg = cp.yellow },
                    ["@variable"] = { fg = cp.text },
                    ["@tag.attribute"] = { fg = cp.mauve, style = { "italic" } },
                    ["@tag"] = { fg = cp.peach },
                    ["@tag.delimiter"] = { fg = cp.maroon },
                    ["@text"] = { fg = cp.text },

                    -- ["@text.uri"] = { fg = cp.rosewater, style = { "italic", "underline" } },
                    -- ["@text.literal"] = { fg = cp.teal, style = { "italic" } },
                    -- ["@text.reference"] = { fg = cp.lavender, style = { "bold" } },
                    -- ["@text.title"] = { fg = cp.blue, style = { "bold" } },
                    -- ["@text.emphasis"] = { fg = cp.maroon, style = { "italic" } },
                    -- ["@text.strong"] = { fg = cp.maroon, style = { "bold" } },
                    -- ["@string.escape"] = { fg = cp.pink },

                    -- ["@property.toml"] = { fg = cp.blue },
                    -- ["@field.yaml"] = { fg = cp.blue },

                    -- ["@label.json"] = { fg = cp.blue },

                    ["@function.builtin.bash"] = { fg = cp.red, style = { "italic" } },
                    ["@parameter.bash"] = { fg = cp.yellow, style = { "italic" } },

                    ["@field.lua"] = { fg = cp.lavender },
                    ["@constructor.lua"] = { fg = cp.flamingo },

                    ["@constant.java"] = { fg = cp.teal },

                    ["@property.typescript"] = { fg = cp.lavender, style = { "italic" } },
                    -- ["@constructor.typescript"] = { fg = cp.lavender },

                    -- ["@constructor.tsx"] = { fg = cp.lavender },
                    -- ["@tag.attribute.tsx"] = { fg = cp.mauve },

                    ["@type.css"] = { fg = cp.lavender },
                    ["@property.css"] = { fg = cp.yellow, style = { "italic" } },

                    ["@property.cpp"] = { fg = cp.text },

                    -- ["@symbol"] = { fg = cp.flamingo },
                }
            end,
        },
    })
end

function config.nvim_tree()
    local icons = {
        diagnostics = require("ui.icons").get("diagnostics"),
        documents = require("ui.icons").get("documents"),
        git = require("ui.icons").get("git"),
        ui = require("ui.icons").get("ui"),
    }

    require("nvim-tree").setup({
        create_in_closed_folder = false,
        respect_buf_cwd = false,
        auto_reload_on_write = true,
        disable_netrw = false,
        hijack_cursor = true,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        ignore_buffer_on_setup = false,
        open_on_setup = false,
        open_on_setup_file = false,
        open_on_tab = false,
        sort_by = "name",
        sync_root_with_cwd = true,
        view = {
            adaptive_size = false,
            centralize_selection = false,
            width = 30,
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            hide_root_folder = false,
            float = {
                enable = false,
                open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 30,
                    height = 30,
                    row = 1,
                    col = 1,
                },
            },
        },
        renderer = {
            add_trailing = false,
            group_empty = true,
            highlight_git = false,
            full_name = false,
            highlight_opened_files = "none",
            special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
            symlink_destination = true,
            indent_markers = {
                enable = true,
                icons = {
                    corner = "└ ",
                    edge = "│ ",
                    item = "│ ",
                    none = "  ",
                },
            },
            root_folder_label = ":.:s?.*?/..?",
            icons = {
                webdev_colors = true,
                git_placement = "before",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = false,
                    git = true,
                },
                padding = " ",
                symlink_arrow = "  ",
                glyphs = {
                    default = icons.documents.Default, --
                    symlink = icons.documents.Symlink, --
                    bookmark = icons.ui.Bookmark,
                    git = {
                        unstaged = icons.git.Mod_alt,
                        staged = icons.git.Add, --
                        unmerged = icons.git.Unmerged,
                        renamed = icons.git.Rename, --
                        untracked = icons.git.Untracked, -- "ﲉ"
                        deleted = icons.git.Remove, --
                        ignored = icons.git.Ignore, --◌
                    },
                    folder = {
                        -- arrow_open = "",
                        -- arrow_closed = "",
                        arrow_open = "",
                        arrow_closed = "",
                        default = icons.ui.Folder,
                        open = icons.ui.FolderOpen,
                        empty = icons.ui.EmptyFolder,
                        empty_open = icons.ui.EmptyFolderOpen,
                        symlink = icons.ui.SymlinkFolder,
                        symlink_open = icons.ui.FolderOpen,
                    },
                },
            },
        },
        hijack_directories = {
            enable = true,
            auto_open = true,
        },
        update_focused_file = {
            enable = true,
            update_root = false,
            ignore_list = {},
        },
        ignore_ft_on_setup = {},
        filters = {
            dotfiles = false,
            custom = { ".DS_Store" },
            exclude = {},
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false,
            },
            open_file = {
                quit_on_open = false,
                resize_window = false,
                window_picker = {
                    enable = true,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", "terminal", "help" },
                    },
                },
            },
            remove_file = {
                close_window = true,
            },
        },
        diagnostics = {
            enable = false,
            show_on_dirs = false,
            debounce_delay = 50,
            icons = {
                hint = icons.diagnostics.Hint_alt,
                info = icons.diagnostics.Information_alt,
                warning = icons.diagnostics.Warning_alt,
                error = icons.diagnostics.Error_alt,
            },
        },
        filesystem_watchers = {
            enable = true,
            debounce_delay = 50,
        },
        git = {
            enable = true,
            ignore = true,
            show_on_dirs = true,
            timeout = 400,
        },
        trash = {
            cmd = "gio trash",
            require_confirm = true,
        },
        live_filter = {
            prefix = "[FILTER]: ",
            always_show_folders = true,
        },
        log = {
            enable = false,
            truncate = false,
            types = {
                all = false,
                config = false,
                copy_paste = false,
                dev = false,
                diagnostics = false,
                git = false,
                profile = false,
                watcher = false,
            },
        },
    })
end

function config.nvim_bufferline()
    local icons = { ui = require("ui.icons").get("ui") }

    local opts = {
        options = {
            number = nil,
            modified_icon = icons.ui.Modified,
            buffer_close_icon = icons.ui.Close,
            left_trunc_marker = icons.ui.Left,
            right_trunc_marker = icons.ui.Right,
            max_name_length = 14,
            max_prefix_length = 13,
            tab_size = 20,
            show_buffer_close_icons = true,
            show_buffer_icons = true,
            show_tab_indicators = true,
            diagnostics = "nvim_lsp",
            always_show_bufferline = true,
            separator_style = "thin",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    padding = 1,
                },
                {
                    filetype = "undotree",
                    text = "Undo Tree",
                    text_align = "center",
                    highlight = "Directory",
                    separator = true,
                },
            },
            diagnostics_indicator = function(count)
                return "(" .. count .. ")"
            end,
        },
        -- Change bufferline's highlights here! See `:h bufferline-highlights` for detailed explanation.
        -- Note: If you use catppuccin then modify the colors below!
        highlights = {},
    }

    require("bufferline").setup(opts)
end

function config.gitsigns()
    require("gitsigns").setup({
        signs = {
            add = {
                hl = "GitSignsAdd",
                text = "│",
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn",
            },
            change = {
                hl = "GitSignsChange",
                text = "│",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
            delete = {
                hl = "GitSignsDelete",
                text = "_",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = "‾",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            changedelete = {
                hl = "GitSignsChange",
                text = "~",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
        },
        keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,
            ["n ]g"] = {
                expr = true,
                "&diff ? ']g' : '<Cmd>lua require\"gitsigns\".next_hunk()<CR>'",
            },
            ["n [g"] = {
                expr = true,
                "&diff ? '[g' : '<Cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
            },
            ["n <Leader>hs"] = '<Cmd>lua require"gitsigns".stage_hunk()<CR>',
            ["v <Leader>hs"] = '<Cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ["n <Leader>hu"] = '<Cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
            ["n <Leader>hr"] = '<Cmd>lua require"gitsigns".reset_hunk()<CR>',
            ["v <Leader>hr"] = '<Cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ["n <Leader>hR"] = '<Cmd>lua require"gitsigns".reset_buffer()<CR>',
            ["n <Leader>hp"] = '<Cmd>lua require"gitsigns".preview_hunk()<CR>',
            ["n <Leader>hb"] = '<Cmd>lua require"gitsigns".blame_line({full=true})<CR>',
            -- Text objects
            ["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
            ["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
        },
        watch_gitdir = { interval = 1000, follow_files = true },
        current_line_blame = true,
        current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        word_diff = false,
        diff_opts = { internal = true },
    })
end

function config.indent_blankline()
    require("indent_blankline").setup({
        char = "│",
        show_first_indent_level = true,
        filetype_exclude = {
            "startify",
            "dashboard",
            "dotooagenda",
            "log",
            "fugitive",
            "gitcommit",
            "packer",
            "vimwiki",
            "markdown",
            "json",
            "txt",
            "vista",
            "help",
            "todoist",
            "NvimTree",
            "peekaboo",
            "git",
            "TelescopePrompt",
            "undotree",
            "flutterToolsOutline",
            "", -- for all buffers without a file type
        },
        buftype_exclude = { "terminal", "nofile" },
        show_trailing_blankline_indent = false,
        show_current_context = true,
        context_patterns = {
            "class",
            "function",
            "method",
            "block",
            "list_literal",
            "selector",
            "^if",
            "^table",
            "if_statement",
            "while",
            "for",
            "type",
            "var",
            "import",
        },
        space_char_blankline = " ",
    })
end

function config.scrollview()
    require("scrollview").setup({})
end

return config
