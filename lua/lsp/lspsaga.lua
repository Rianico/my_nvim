local icons = {
    diagnostics = require("ui.icons").get("diagnostics", true),
    kind = require("ui.icons").get("kind", true),
    type = require("ui.icons").get("type", true),
    ui = require("ui.icons").get("ui", true),
}

local function set_sidebar_icons()
    -- Set icons for sidebar.
    local diagnostic_icons = {
        Error = icons.diagnostics.Error_alt,
        Warn = icons.diagnostics.Warning_alt,
        Info = icons.diagnostics.Information_alt,
        Hint = icons.diagnostics.Hint_alt,
    }
    for type, icon in pairs(diagnostic_icons) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl })
    end
end

local function get_palette()
    -- Default behavior: return lspsaga's default palette.
    local palette = require("lspsaga.lspkind").colors
    palette.peach = palette.orange
    palette.flamingo = palette.orange
    palette.rosewater = palette.yellow
    palette.mauve = palette.violet
    palette.sapphire = palette.blue
    palette.maroon = palette.orange

    return palette
end

local function set_highlight()
    local highlights = {
        -- code action
        LspSagaCodeActionTitle = { fg = "#da8548", bold = true },
        LspSagaCodeActionBorder = { fg = "#CBA6F7" },
        LspSagaCodeActionTrunCateLine = { link = "LspSagaCodeActionBorder" },
        LspSagaCodeActionContent = { fg = "#98be65", bold = true },
        -- finder
        LspSagaLspFinderBorder = { fg = "#51afef" },
        LspSagaAutoPreview = { fg = "#51afef" },
        LspSagaFinderSelection = { fg = "#89d957", bold = true },
        TargetFileName = { fg = "#d1d4cf" },
        FinderParam = { fg = "#CBA6F7", bg = "#392a52", bold = true },
        FinderVirtText = { fg = "#c95942" },
        DefinitionsIcon = { fg = "#e3e346" },
        Definitions = { fg = "#CBA6F7", bold = true },
        DefinitionCount = { link = "Title" },
        ReferencesIcon = { fg = "#e3e346" },
        References = { fg = "#CBA6F7", bold = true },
        ReferencesCount = { link = "Title" },
        ImplementsIcon = { fg = "#e3e346" },
        Implements = { fg = "#CBA6F7", bold = true },
        ImplementsCount = { link = "Title" },
        --finder spinner
        FinderSpinnerBorder = { fg = "#51afef" },
        FinderSpinnerTitle = { fg = "#b33076", bold = true },
        FinderSpinner = { fg = "#b33076", bold = true },
        FinderPreviewSearch = { link = "Search" },
        -- definition
        DefinitionBorder = { fg = "#b3deef" },
        DefinitionArrow = { fg = "#ad475f" },
        DefinitionSearch = { link = "Search" },
        DefinitionFile = { bg = "#151838" },
        -- hover
        LspSagaHoverBorder = { fg = "#f7bb3b" },
        LspSagaHoverTrunCateLine = { link = "LspSagaHoverBorder" },
        -- rename
        LspSagaRenameBorder = { fg = "#3bb6c4" },
        LspSagaRenameMatch = { link = "Search" },
        -- diagnostic
        LspSagaDiagnosticSource = { link = "Comment" },
        LspSagaDiagnosticError = { link = "DiagnosticError" },
        LspSagaDiagnosticWarn = { link = "DiagnosticWarn" },
        LspSagaDiagnosticInfo = { link = "DiagnosticInfo" },
        LspSagaDiagnosticHint = { link = "DiagnosticHint" },
        LspSagaErrorTrunCateLine = { link = "DiagnosticError" },
        LspSagaWarnTrunCateLine = { link = "DiagnosticWarn" },
        LspSagaInfoTrunCateLine = { link = "DiagnosticInfo" },
        LspSagaHintTrunCateLine = { link = "DiagnosticHint" },
        LspSagaDiagnosticBorder = { fg = "#CBA6F7" },
        LspSagaDiagnosticHeader = { fg = "#afd700" },
        DiagnosticQuickFix = { fg = "#4dd158", bold = true },
        DiagnosticMap = { fg = "#cf80ce" },
        DiagnosticLineCol = { fg = "#73797e" },
        LspSagaDiagnosticTruncateLine = { link = "LspSagaDiagnosticBorder" },
        ColInLineDiagnostic = { link = "Comment" },
        -- signture help
        LspSagaSignatureHelpBorder = { fg = "#98be65" },
        LspSagaShTrunCateLine = { link = "LspSagaSignatureHelpBorder" },
        -- lightbulb
        LspSagaLightBulb = { link = "DiagnosticSignHint" },
        -- shadow
        SagaShadow = { fg = "black" },
        -- float
        LspSagaBorderTitle = { link = "String" },
        -- Outline
        LSOutlinePreviewBorder = { fg = "#52ad70" },
        OutlineIndentEvn = { fg = "#c955ae" },
        OutlineIndentOdd = { fg = "#b8733e" },
        OutlineFoldPrefix = { fg = "#bf4537" },
        OutlineDetail = { fg = "#73797e" },
        -- all floatwindow of lspsaga
        LspFloatWinNormal = { link = "Normal" },
    }

    for group, conf in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, vim.tbl_extend("keep", conf, { default = true }))
    end
end

set_sidebar_icons()
set_highlight()

local colors = get_palette()

require("lspsaga").init_lsp_saga({
    border_style = "rounded",
    saga_winblend = 0,
    diagnostic_header = {
        icons.diagnostics.Error,
        icons.diagnostics.Warning_alt,
        icons.diagnostics.Information_alt,
        icons.diagnostics.Hint_alt,
    },
    custom_kind = {
        -- Kind
        Class = { icons.kind.Class, colors.yellow },
        Constant = { icons.kind.Constant, colors.peach },
        Constructor = { icons.kind.Constructor, colors.sapphire },
        Enum = { icons.kind.Enum, colors.yellow },
        EnumMember = { icons.kind.EnumMember, colors.teal },
        Event = { icons.kind.Event, colors.yellow },
        Field = { icons.kind.Field, colors.teal },
        File = { icons.kind.File, colors.rosewater },
        Function = { icons.kind.Function, colors.blue },
        Interface = { icons.kind.Interface, colors.yellow },
        Key = { icons.kind.Keyword, colors.red },
        Method = { icons.kind.Method, colors.blue },
        Module = { icons.kind.Module, colors.blue },
        Namespace = { icons.kind.Namespace, colors.blue },
        Number = { icons.kind.Number, colors.peach },
        Operator = { icons.kind.Operator, colors.sky },
        Package = { icons.kind.Package, colors.blue },
        Property = { icons.kind.Property, colors.teal },
        Struct = { icons.kind.Struct, colors.yellow },
        TypeParameter = { icons.kind.TypeParameter, colors.maroon },
        Variable = { icons.kind.Variable, colors.peach },
        -- Type
        Array = { icons.type.Array, colors.peach },
        Boolean = { icons.type.Boolean, colors.peach },
        Null = { icons.type.Null, colors.yellow },
        Object = { icons.type.Object, colors.yellow },
        String = { icons.type.String, colors.green },
        -- ccls-specific iconss.
        TypeAlias = { icons.kind.TypeAlias, colors.green },
        Parameter = { icons.kind.Parameter, colors.blue },
        StaticMethod = { icons.kind.StaticMethod, colors.peach },
    },
    symbol_in_winbar = {
        enable = false,
        in_custom = true,
        separator = " " .. icons.ui.Separator,
        show_file = true,
        -- define how to customize filename, eg: %:., %
        -- if not set, use default value `%:t`
        -- more information see `vim.fn.expand` or `expand`
        -- ## only valid after set `show_file = true`
        file_formatter = "",
        click_support = function(node, clicks, button, modifiers)
            -- To see all avaiable details: vim.pretty_print(node)
            local st = node.range.start
            local en = node.range["end"]
            if button == "l" then
                if clicks == 2 then
                    -- double left click to do nothing
                else -- jump to node's starting line+char
                    vim.fn.cursor(st.line + 1, st.character + 1)
                end
            elseif button == "r" then
                if modifiers == "s" then
                    print("lspsaga") -- shift right click to print "lspsaga"
                end -- jump to node's ending line+char
                vim.fn.cursor(en.line + 1, en.character + 1)
            elseif button == "m" then
                -- middle click to visual select node
                vim.fn.cursor(st.line + 1, st.character + 1)
                vim.api.nvim_command([[normal v]])
                vim.fn.cursor(en.line + 1, en.character + 1)
            end
        end,
    },
    -- show outline
    show_outline = {
        win_position = "right",
        --set special filetype win that outline window split.like NvimTree neotree
        -- defx, db_ui
        win_with = "",
        win_width = 60,
        auto_enter = true,
        auto_preview = true,
        virt_text = "┃",
        jump_key = "o",
        -- auto refresh when change buffer
        auto_refresh = true,
    },
    finder_action_keys = {
        open = { "o", "<CR>" },
        vsplit = "v",
        split = "s",
        tabe = "t",
        quit = { "q" },
    },
    code_action_keys = {
        quit = "q",
        exec = "<CR>",
    },
    definition_action_keys = {
        edit = "<Esc>o",
        vsplit = "<Esc>v",
        split = "<Esc>i",
        tabe = "<Esc>t",
        quit = "q",
    },
})
require("keybindings").lspsaga_mapping()
