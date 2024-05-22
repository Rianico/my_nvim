vim.g.mapleader = ","
vim.g.maplocalleader = ","

local map = vim.keymap.set
local opt = { noremap = true, silent = true }

-- local feedkey = function(key, mode)
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
-- end

-- emacs style shorten
map("n", "<C-a>", "^", opt)
map("n", "<C-e>", "$", opt)
map("i", "<C-a>", "<C-o><S-i>", opt)
map("i", "<C-e>", "<C-o><S-a>", opt)
-- delete character afterward
map("i", "<C-d>", "<C-o>s", opt)
-- save and quit
map("n", "<C-s>", ":w<CR>", opt)
map("i", "<C-s>", "<Esc>:w<CR>", opt)
map("n", "<C-q>", ":confirm q<CR>", opt)

--terminal
map("t", "<esc>", [[<C-n>]], opt)

-- window
map("n", "<Leader>q", "<C-w>c", opt)
map({ "t", "n" }, "<C-h>", [[<Cmd>wincmd h<CR>]], opt)
map({ "t", "n" }, "<C-j>", [[<Cmd>wincmd j<CR>]], opt)
map({ "t", "n" }, "<C-k>", [[<Cmd>wincmd k<CR>]], opt)
map({ "t", "n" }, "<C-l>", [[<Cmd>wincmd l<CR>]], opt)

-- vista.vim
map("n", "<Leader><Leader>", ":Vista!!<CR>", { noremap = true })

-- bufferline
map("n", ";1", "<Cmd>BufferLineGoToBuffer 1<CR>", opt)
map("n", ";2", "<Cmd>BufferLineGoToBuffer 2<CR>", opt)
map("n", ";3", "<Cmd>BufferLineGoToBuffer 3<CR>", opt)
map("n", ";4", "<Cmd>BufferLineGoToBuffer 4<CR>", opt)
map("n", ";5", "<Cmd>BufferLineGoToBuffer 5<CR>", opt)
map("n", ";6", "<Cmd>BufferLineGoToBuffer 6<CR>", opt)
map("n", ";7", "<Cmd>BufferLineGoToBuffer 7<CR>", opt)
map("n", ";8", "<Cmd>BufferLineGoToBuffer 8<CR>", opt)
map("n", "[t", "<Cmd>BufferLineCyclePrev<CR>", opt)
map("n", "]t", "<Cmd>BufferLineCycleNext<CR>", opt)

-- local search
map("n", "<C-n>", "<Cmd>noh<CR>", opt)

local wk = require("which-key")
wk.setup({
    window = {
        border = "double",   -- none, single, double, shadow
        position = "bottom", -- bottom, top
    },
})
local wk_opts = {
    mode = "n", -- NORMAL mode
    -- prefix: use "<Leader>f" for example for mapping everything related to finding files
    -- the prefix is prepended to every mapping part of `mappings`
    prefix = "",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

-- telescope
map("n", "<C-p>", "<Cmd>Telescope find_files<CR>", opt)
map("n", "<C-S-p>", "<Cmd>Telescope commands<CR>", opt)

-- :buffers
map("n", "<Leader>b", "<Cmd>Telescope buffers<CR>", opt)

-- Zen Mode
map("n", "<Leader>z", "<Cmd>ZenMode<CR>", opt)

wk.register({
    -- registers
    -- list registers:
    --   normal mode: "
    --   insert mode: <C-r>
    ["<Leader>r"] = {
        name = "Registers",
        r = { "<Cmd>Telescope neoclip<CR>", "Neoclip" },
        t = { "<Cmd>Telescope registers<CR>", "Telescope Registers" },
    },

    -- telescope
    ["<Leader>f"] = {
        name = "Files",
        f = { "<Cmd>Telescope current_buffer_fuzzy_find<CR>", "Grep Current Buffer" },
        g = { "<Cmd>Telescope live_grep<CR>", "Grep All Files" },
        e = { "<Cmd>Telescope file_browser<CR>", "File Browser" },
        E = { "<Cmd>NvimTreeFindFileToggle<CR>", "File Explorer" },
    },

    -- harpoon
    ["<Leader>h"] = {
        name = "Harpoon",
        h = { "<Cmd>lua require('harpoon.mark').add_file()<CR>", "Add File To Quick Menu" },
        t = { "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toogle Quick Menu" },
        T = { "<Cmd>Telescope harpoon marks<CR>", "Telescope Quick Menu" },
    },

    -- marks
    ["<Leader>m"] = {
        name = "Marks",
        -- list marks: ' in normal mode
        d = { "<Plug>(Marks-delete)", "Delete Input Marks" },
        l = { "<Plug>(Marks-deleteline)", "Delete Line Marks" },
        D = { "<Plug>(Marks-deletebuf)", "Delete Buffer Marks" },
        a = { "<Cmd>delmarks a-zA-Z0-9<CR>", "Delete All Marks" },
        t = { "<Cmd>Telescope marks<CR>", "Telescope Marks" },
        m = { "<Cmd>MarksListBuf<CR>", "Buffer Marks" },
    },
    ["m"] = {
        name = "Marks",
        m = { "<Plug>(Marks-setnext)", "Marks SetNext" },
    },

    -- gitsigns
    ["<Leader>g"] = {
        name = "Gits",
        s = { "<Cmd>Gitsigns stage_hunk<CR>", "Stage Hunk" },
        r = { "<Cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },

        u = { "<Cmd>Gitsigns undo_stage_hunk<CR>", "Unstage Hunk" },

        S = { "<Cmd>Gitsigns stage_buffer<CR>", "Stage Buffer" },
        R = { "<Cmd>Gitsigns reset_buffer<CR>", "Reset Buffer" },

        d = { "<Cmd>Gitsigns toggle_deleted<CR>", "Toggle Deleted" },
        D = { "<Cmd>Gitsigns diffthis<CR>", "Diff" },

        l = { "<Cmd>Gitsigns toggle_current_line_blame<CR>", "Line Blame" },
        p = { "<Cmd>Gitsigns preview_hunk<CR>", "Preview Hunk" },

        c = { "<Cmd>Gitsigns toggle_signs<CR>", "Sign Column" },
        h = { "<Cmd>Gitsigns toggle_linehl<CR>", "Toggle Linehl" },

        g = {
            "<Cmd>lua require('toggleterm.terminal').Terminal:new({ cmd = 'gitui', hidden = true, count = 9, direction = 'tab' }):toggle()<CR>",
            "Gitui",
        },
    },

    -- toggleterm
    ["<Leader>t"] = {
        name = "ToggleTerm",
        -- <C-\> ToggleTerm
        h = { "<Cmd>ToggleTerm direction=horizontal<CR>", "Toggle HTerminal" },
        v = { "<Cmd>ToggleTerm direction=vertical<CR>", "Toggle VTerminal" },
    },
}, wk_opts)

-- gitsigns
local gs = require("gitsigns")
map("n", "]c", function()
    if vim.wo.diff then
        return "]c"
    end
    vim.schedule(function()
        gs.next_hunk()
    end)
    return "<Ignore>"
end, { expr = true })
map("n", "[c", function()
    if vim.wo.diff then
        return "[c"
    end
    vim.schedule(function()
        gs.prev_hunk()
    end)
    return "<Ignore>"
end, { expr = true })

local pluginKeys = {}
-- For NvimTree
pluginKeys.nvim_tree_on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Default mappings. Feel free to modify or remove as you wish.
    --
    -- BEGIN_DEFAULT_ON_ATTACH
    vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
    vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
    vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
    vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
    vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
    vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
    vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
    vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
    vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
    vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
    vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
    vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
    vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
    vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
    vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
    vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
    vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
    vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
    vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
    vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
    vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
    vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
    vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
    vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
    vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
    vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
    vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
    vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
    vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
    vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
    vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
    vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
    vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
    vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
    vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
    -- END_DEFAULT_ON_ATTACH


    -- Mappings migrated from view.mappings.list
    --
    -- You will need to insert "your code goes here" for any mappings with a custom action_cb
    vim.keymap.set('n', '<CR>', api.node.open.tab, opts('Open: New Tab'))
    vim.keymap.set('n', 'o', api.node.open.tab, opts('Open: New Tab'))
    vim.keymap.set('n', 'e', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
    vim.keymap.set('n', 'o', api.node.run.system, opts('Run System'))
end

-- For vim.lsp
---@diagnostic disable-next-line: unused-local
pluginKeys.on_attach = function(client, bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- finished by lspsaga
    -- vim.keymap.set("n", "<space>d", vim.lsp.buf.type_definition, bufopts)
    -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
end

-- For cmp
pluginKeys.cmp_mapping = function(cmp)
    -- local has_words_before = function()
    -- 	local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    -- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    -- end
    local M = {}
    local ls = require("luasnip")
    M = {
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-L>"] = cmp.mapping(function(fallback)
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { "i", "s" }),
        ["<C-J>"] = cmp.mapping(function(fallback)
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, { "i", "s" }),
    }
    return M
end

-- For rust-tools
pluginKeys.rust_tools_mapping = function(client, bufnr)
    pluginKeys.on_attach(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<Space>d", ":RustHoverAction<CR>", bufopts)
    vim.keymap.set("n", "<Space>e", ":RustExpandMacro<CR>", bufopts)
    vim.keymap.set("n", "<Space>p", ":RustParentModule<CR>", bufopts)
end

-- For lspsaga
-- Finished by lspsaga
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opt)
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
pluginKeys.lspsaga_mapping = function()
    local bufopts = { noremap = true, silent = true }

    map("n", "gr", "<Cmd>Lspsaga finder<CR>", bufopts)
    map("n", "gd", "<Cmd>Lspsaga peek_definition<CR>", bufopts)
    map("n", "gD", "<Cmd>Lspsaga goto_definition<CR>", bufopts)
    map("n", "K", "<Cmd>Lspsaga hover_doc ++keep<CR>", bufopts)
    -- Outline
    map("n", "<Leader>ll", "<Cmd>Lspsaga outline<CR>", bufopts)
    -- Call hierarchy
    map("n", "<Leader>li", "<Cmd>Lspsaga incoming_calls<CR>", bufopts)
    map("n", "<Leader>lo", "<Cmd>Lspsaga outgoing_calls<CR>", bufopts)
    -- Code action
    map({ "n", "v" }, "<Space>ca", "<Cmd>Lspsaga code_action<CR>", bufopts)
    -- Rename
    map("n", "<space>r", "<Cmd>Lspsaga rename<CR>", bufopts)
    -- Diagnsotic jump can use `<c-o>` to jump back
    map("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
    map("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
    -- Only jump to error
    map("n", "[D", function()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, bufopts)
    map("n", "]D", function()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, bufopts)
end
pluginKeys.lspsaga_finder_keys = {
    shuttle = "p",
    toggle_or_open = { "o", "<CR>" },
    vsplit = "v",
    split = "s",
    tabe = "t",
    tabnew = "T",
    quit = { "q", "<ESC>" },
}
pluginKeys.lspsaga_code_action_keys = {
    -- string | table type
    quit = { "q", "<ESC>" },
    exec = "<CR>",
}
pluginKeys.lspsaga_definition_keys = {
    edit = "<Leader>e",
    vsplit = "<Leader>v",
    split = "<Leader>s",
    tabe = "<Leader>t",
    quit = "q",
}
pluginKeys.lspsaga_callhierarchy_keys = {
    edit = "e",
    vsplit = "v",
    split = "s",
    tabe = "t",
    jump = "<Tab>",
    quit = "q",
    expand_collapse = "u",
}
pluginKeys.lspsaga_diagnostic_keys = {
    exec_action = "<CR>",
    quit = "q",
    -- 跳转到 code action
    go_action = "g",
}

-- For trouble
pluginKeys.trouble_action_keys = {
    -- key mappings for actions in the trouble list
    -- map to {} to remove a mapping, for example:
    -- close = {}
    close = "q",                  -- close the list
    cancel = "<esc>",             -- cancel the preview and get back to your last window / buffer / cursor
    refresh = "r",                -- manually refresh
    jump = { "<CR>", "<tab>" },   -- jump to the diagnostic or open / close folds
    open_split = { "<c-s>" },     -- open buffer in new split
    open_vsplit = { "<c-v>" },    -- open buffer in new vsplit
    open_tab = { "<c-t>" },       -- open buffer in new tab
    jump_close = { "o" },         -- jump to the diagnostic and close the list
    toggle_mode = "m",            -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = "P",         -- toggle auto_preview
    hover = "K",                  -- opens a small popup with the full multiline message
    preview = "p",                -- preview the diagnostic location
    close_folds = { "Z" },        -- close all folds
    open_folds = { "z" },         -- open all folds
    toggle_fold = { "zA", "za" }, -- toggle fold of current file
    previous = "k",               -- previous item
    next = "j",                   -- next item
}
pluginKeys.trouble_mapping = function()
    -- Lua
    map("n", "<Leader>xx", "<Cmd>TroubleToggle<CR>", { silent = true, noremap = true })
    map("n", "<Leader>xw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", { silent = true, noremap = true })
    map("n", "<Leader>xd", "<Cmd>TroubleToggle document_diagnostics<CR>", { silent = true, noremap = true })
    map("n", "<Leader>xl", "<Cmd>TroubleToggle loclist<CR>", { silent = true, noremap = true })
    map("n", "<Leader>xq", "<Cmd>TroubleToggle quickfix<CR>", { silent = true, noremap = true })
    map("n", "gR", "<Cmd>TroubleToggle lsp_references<CR>", { silent = true, noremap = true })
end

return pluginKeys
