vim.g.mapleader = ","
vim.g.maplocalleader = ","

local map = vim.keymap.set
local opt = { noremap = true, silent = true }

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

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
-- close current window
map("n", "<leader>q", "<C-w>c", opt)

-- vista.vim
map("n", "<leader><leader>", ":Vista!!<CR>", { noremap = true })

-- bufferline
-- map("n", "<leader>p", "<Cmd>BufferLinePick<CR>", opt)
-- map("n", "<leader>P", "<Cmd>BufferLinePickClose<CR>", opt)
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

-- hlslens
vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opt)
vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opt)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], opt)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], opt)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], opt)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], opt)
vim.api.nvim_set_keymap('n', '<Leader>n', '<Cmd>noh<CR>', opt)

local wk = require("which-key")
wk.setup({
    window = {
        border = "double", -- none, single, double, shadow
        position = "bottom", -- bottom, top
    },
})
local wk_opts = {
    mode = "n", -- NORMAL mode
    -- prefix: use "<leader>f" for example for mapping everything related to finding files
    -- the prefix is prepended to every mapping part of `mappings`
    prefix = "",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

-- telescope
map("n", "<C-p>", "<Cmd>Telescope find_files<CR>", opt)

map("n", "<C-S-p>", "<Cmd>Telescope commands<CR>", opt)
-- :buffers
map("n", "<leader>b", "<Cmd>Telescope buffers<CR>", opt)

wk.register({
    -- registers
    -- list registers:
    --   normal mode: "
    --   insert mode: <C-/>
    ["<leader>r"] = {
        name = "Registers",
        r = { "<Cmd>Telescope neoclip<CR>", "Neoclip" },
        t = { "<Cmd>Telescope registers<CR>", "Telescope Registers" },
    },

    -- telescope
    ["<leader>f"] = {
        name = "Files",
        f = { "<Cmd>Telescope current_buffer_fuzzy_find<CR>", "Grep Current Buffer" },
        g = { "<Cmd>Telescope live_grep<CR>", "Grep All Files" },
        e = { "<Cmd>Telescope file_browser<CR>", "File Browser" },
        E = { "<Cmd>NvimTreeToggle<CR>", "File Explorer" },
    },

    -- harpoon
    ["<leader>h"] = {
        name = "Harpoon",
        h = { "<Cmd>lua require('harpoon.mark').add_file()<CR>", "Add File To Quick Menu" },
        t = { "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toogle Quick Menu" },
        T = { "<Cmd>Telescope harpoon marks<CR>", "Telescope Quick Menu" },
    },

    -- marks
    ["<leader>m"] = {
        name = "Marks",
        -- list marks: ' in normal mode
        d = { "<Plug>(Marks-delete)", "Delete Input Marks" },
        l = { "<Plug>(Marks-deleteline)", "Delete Line Marks" },
        a = { "<Plug>(Marks-deletebuf)", "Delete Buffer Marks" },
        A = { "<Cmd>delmarks a-zA-Z0-9<CR>", "Delete All Marks" },
        t = { "<Cmd>Telescope marks<CR>", "Telescope Marks" },
    },
    ["m"] = {
        name = "Marks",
        m = { "<Plug>(Marks-setnext)", "Marks SetNext" },
    },

    -- gitsigns
    ["<leader>g"] = {
        name = "Gits",
        s = { "<Cmd>Gitsigns stage_hunk<CR>", "stage hunk" },
        r = { "<Cmd>Gitsigns reset_hunk<CR>", "reset hunk" },

        u = { "<Cmd>Gitsigns undo_stage_hunk<CR>", "unstage hunk" },

        S = { "<Cmd>Gitsigns stage_buffer<CR>", "stage buffer" },
        R = { "<Cmd>Gitsigns stage_buffer<CR>", "stage buffer" },

        d = { "<cmd>Gitsigns toggle_deleted<CR>", "toggle deleted" },
        D = { "<Cmd>Gitsigns diffthis<CR>", "diff" },

        l = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "line blame" },
        p = { "<cmd>Gitsigns preview_hunk<CR>", "preview hunk" },
    }
}, wk_opts)

-- gitsigns
local gs = require("gitsigns")
map('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
end, { expr = true })
map('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
end, { expr = true })

local pluginKeys = {}
-- For NvimTree
pluginKeys.nvimTreeList = {
    -- 打开文件或件夹
    { key = { "<CR>", "o" }, action = "tabnew" },
    { key = "e", action = "edit" },
    -- 分屏打开文件
    { key = "v", action = "vsplit" },
    -- 文件操作
    { key = "a", action = "create" },
    { key = "d", action = "remove" },
    { key = "r", action = "rename" },
    { key = "x", action = "cut" },
    { key = "c", action = "copy" },
    { key = "p", action = "paste" },
    { key = "o", action = "system_open" },
}

-- For vim.lsp
---@diagnostic disable-next-line: unused-local
pluginKeys.on_attach = function(client, bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- finished by lspsaga
    -- vim.keymap.set("n", "<space>d", vim.lsp.buf.type_definition, bufopts)
    -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
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
    local has_words_before = function()
        local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
    local M = {}
    M = {
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
                -- elseif require("luasnip").expand_or_jumpable() then
                -- 	vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn("vsnip#jumpable(-1)")[1] then
                feedkey("<Plug>(vsnip-jump-prev)", "")
                -- elseif require("luasnip").jumpable(-1) then
                -- 	vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
            else
                fallback()
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
    vim.keymap.set("n", "<Space>r", require("rust-tools").runnables.runnables, bufopts)
    vim.keymap.set("n", "<Space>k", ":RustMoveItemUp<CR>", bufopts)
    vim.keymap.set("n", "<Space>j", ":RustMoveItemDown<CR>", bufopts)
    vim.keymap.set("n", "<Space>em", ":RustExpandMacro<CR>", bufopts)
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

    map("n", "gr", "<Cmd>Lspsaga lsp_finder<CR>", bufopts)
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
    map("n", "<space>R", "<Cmd>Lspsaga rename<CR>", bufopts)

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

    -- pass somc cli command into a floating terminal and execute it.
    map("n", "<A-d>", "<Cmd>Lspsaga term_toggle gitui<CR>", bufopts)
    -- close floaterm
    map("t", "<A-d>", "<Cmd>Lspsaga term_toggle<CR>", bufopts)
end
pluginKeys.lspsaga_finder_keys = {
    jump_to = "p",
    edit = { "o", "<CR>" },
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
pluginKeys.trouble_action_keys = { -- key mappings for actions in the trouble list
    -- map to {} to remove a mapping, for example:
    -- close = {}
    close = "q", -- close the list
    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
    refresh = "r", -- manually refresh
    jump = { "<CR>", "<tab>" }, -- jump to the diagnostic or open / close folds
    open_split = { "<c-s>" }, -- open buffer in new split
    open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
    open_tab = { "<c-t>" }, -- open buffer in new tab
    jump_close = { "o" }, -- jump to the diagnostic and close the list
    toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = "P", -- toggle auto_preview
    hover = "K", -- opens a small popup with the full multiline message
    preview = "p", -- preview the diagnostic location
    close_folds = { "Z" }, -- close all folds
    open_folds = { "z" }, -- open all folds
    toggle_fold = { "zA", "za" }, -- toggle fold of current file
    previous = "k", -- previous item
    next = "j", -- next item
}
pluginKeys.trouble_mapping = function()
    -- Lua
    map("n", "<leader>xx", "<Cmd>TroubleToggle<CR>", { silent = true, noremap = true })
    map("n", "<leader>xw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", { silent = true, noremap = true })
    map("n", "<leader>xd", "<Cmd>TroubleToggle document_diagnostics<CR>", { silent = true, noremap = true })
    map("n", "<leader>xl", "<Cmd>TroubleToggle loclist<CR>", { silent = true, noremap = true })
    map("n", "<leader>xq", "<Cmd>TroubleToggle quickfix<CR>", { silent = true, noremap = true })
    map("n", "gR", "<Cmd>TroubleToggle lsp_references<CR>", { silent = true, noremap = true })
end

return pluginKeys
