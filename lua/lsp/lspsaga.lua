local icons = {
  diagnostics = require("ui.icons").get("diagnostics", true),
  ui = require("ui.icons").get("ui", true),
}

local keybindings = require("keybindings")

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

require("lspsaga").setup({
  -- preview lines above of lsp_finder
  preview = {
    lines_above = 8,
    lines_below = 10,
  },
  -- preview lines of lsp_finder and definition preview
  max_preview_lines = 20,
  -- use emoji lightbulb in default
  finder_request_timeout = 6000,
  ui = {
    -- Border type can be single, double, rounded, solid, shadow.
    border = "rounded",
    devicon = true,
    title = true,
    expand = "",
    collapse = "",
    code_action = "",
    -- diagnostic = "🐞",
    actionfix = "🦀️",
  },
  -- show outline
  outline = {
    win_position = "right",
    win_width = 50,
    detail = true,
    auto_preview = false,
    auto_close = true,
    close_after_jump = false,
    keys = {
      jump = { "e", "<CR>" },
      toggle_or_jump = "u",
      quit = "q",
    },
  },
  finder = {
    keys = keybindings.lspsaga_finder_keys,
    default = "ref+imp+tyd",
  },
  code_action = {
    num_shortcut = true,
    show_server_name = true,
    extend_gitsigns = false,
    keys = keybindings.lspsaga_code_action_keys,
  },
  rename = {
    in_select = false,
    auto_save = true,
    keys = keybindings.lspsaga_rename_keys,
  },
  definition = {
    keys = keybindings.lspsaga_definition_keys,
  },
  callhierarchy = {
    -- float & normal
    layout = "float",
    keys = keybindings.lspsaga_callhierarchy_keys,
  },
  diagnostic = {
    show_code_action = true,
    show_source = true,
    -- <C-f>, <C-b>
    jump_num_shortcut = true,
    show_layout = "float",
    --1 is max
    max_show_width = 0.9,
    max_show_height = 0.556,
    text_hl_follow = true,
    border_follow = true,
    keys = keybindings.lspsaga_diagnostic_keys,
  },
})

require("keybindings").lspsaga_mapping()
