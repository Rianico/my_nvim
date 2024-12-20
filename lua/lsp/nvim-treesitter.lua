---@diagnostic disable: duplicate-index
local icons = {
    diagnostics = require("ui.icons").get("diagnostics"),
    documents = require("ui.icons").get("documents"),
    git = require("ui.icons").get("git"),
    ui = require("ui.icons").get("ui"),
}
require("nvim-treesitter.configs").setup({
    create_in_closed_folder = false,
    respect_buf_cwd = false,
    update_cwd = true,
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
        adaptive_size = true,
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
        update_cwd = true,
        update_root = false,
        ignore_list = {},
    },
    ignore_ft_on_setup = {},
    filters = {
        dotfiles = false,
        custom = { ".DS_Store", ".git" },
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
    -- 安装 language parser
    -- :TSInstallInfo 命令查看支持的语言
    ensure_installed = {
        "python",
        "vim",
        "lua",
        "rust",
        "java",
        "toml",
        "json",
        "yaml",
        "make",
        "sql",
        "html",
        "bash",
        "markdown",
        "go",
    },
    -- 启用代码高亮功能
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    -- 启用增量选择
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<BS>",
            scope_incremental = "<TAB>",
        },
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 2000, -- Do not enable for files with more than 2000 lines, int
    },
    -- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
    indent = {
        enable = true,
    },
})
-- 开启 Folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
vim.wo.foldlevel = 99
-- change rainbow
vim.cmd([[ autocmd FileType * highlight rainbowcol4 guifg=#FF7B72 gui=bold ]])
-- enable .slint files recognization
vim.cmd([[ autocmd BufEnter *.slint :setlocal filetype=slint ]])
