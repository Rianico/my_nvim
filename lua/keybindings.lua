local map = vim.keymap.set
local opt = { noremap = true, silent = true }
local pluginKeys = {}

-- emacs style shorten
map("n", "<C-a>", "^", opt)
map("n", "<C-e>", "$", opt)
map("i", "<C-a>", "<C-o><S-i>", opt)
map("i", "<C-e>", "<C-o><S-a>", opt)
-- delete character afterward
map("i", "<C-d>", "<C-o>s", opt)
map("n", "<C-q>", ":confirm q<CR>", opt)

-- [q, ]q, [Q, ]Q, [CTRL-Q, ]CTRL-Q navigate through the quickfix list
-- [l, ]l, [L, ]L, [CTRL-L, ]CTRL-L navigate through the location list
-- [t, ]t, [T, ]T, [CTRL-T, ]CTRL-T navigate through the tag matchlist
-- [a, ]a, [A, ]A navigate through the argument list
-- [b, ]b, [B, ]B navigate through the buffer list
-- [<Space>, ]<Space> add an empty line above and below the cursor
-- [d and ]d move between diagnostics in the current buffer ([D jumps to the first diagnostic, ]D jumps to the last)
local wk = require("which-key")

wk.add({
  {
    "[e",
    ":lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.E})<CR>",
    desc = "Diagnostics: Last Error",
    hidden = true,
  },
  {
    "]e",
    ":lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.E})<CR>",
    desc = "Diagnostics: Next Error",
    hidden = true,
  },
  {
    "[d",
    ":lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.W})<CR>",
    desc = "Diagnostics: Last Warnning",
    hidden = true,
  },
  {
    "]d",
    ":lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.W})<CR>",
    desc = "Diagnostics: Next Warnning",
    hidden = true,
  },
})

wk.setup({
  preset = "classic", -- "classic" | "modern" | "helix"
  win = {
    no_overlap = false,
    border = "single", -- none, single, double, shadow
    -- position = "bottom", -- bottom, top
    height = { min = 4, max = 25 },
  },
  sort = { "desc", "local", "order", "group", "mod", "alphanum" },
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- z=, correct spell
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 6, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true, -- adds help for operators like d, y, ...
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling, and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
})

-- stylua: ignore start
wk.add({
  { '<leader>"',       function() Snacks.picker.registers() end,          desc = "Picker: Registers", hidden = true },
  { "<leader>'",       function() Snacks.picker.marks() end,              desc = "Picker: Marks", hidden = true },
  { "<leader>n",       function() Snacks.picker.notifications() end,      desc = "Picker: Notification History", hidden = true },
  { "<leader>E",       function() Snacks.explorer() end,                  desc = "Picker: File Explorer", hidden = true },
  { "<leader>z",       function() Snacks.zen() end,                       desc = "Zen mode", hidden = true },
  { "<leader>w",       ":update<CR> :source<CR>",                         desc = "Update & Source", hidden = true },
  {
    "<c-\\>",
    function()
      local shell = vim.fn.executable("zsh") == 1 and "zsh" or "bash"
      return Snacks.terminal.toggle(shell)
    end,
    desc = "Toggle Terminal",
    mode = { "n", "t" },
  },

  -- motions
  {
    { "s",     function() require("flash").jump() end,              mode = { "n", "x", "o" }, desc = "Flash" },
    { "S",     function() require("flash").treesitter() end,        mode = { "n" },           desc = "Flash Treesitter" },
    { "r",     function() require("flash").remote() end,            mode = "o",               desc = "Remote Flash" },
    { "R",     function() require("flash").treesitter_search() end, mode = { "o", "x" },      desc = "Treesitter Search" },
  },

  -- find
  { "<leader>f",  group = "Find"},
  { "<C-p>",       function() Snacks.picker.files() end,                                   desc = "Find Files" },
  { "<leader>ff",  function() Snacks.picker.files() end,                                   desc = "Find Files" },
  { "<leader>fc",  function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config Files" },
  { "<leader>fp",  function() Snacks.picker.projects() end,                                desc = "Projects" },
  { "<leader>fr",  function() Snacks.picker.recent() end,                                  desc = "Recent Files" },

  -- grep
  { "<C-s>", group = "Search" },
  { "<C-s>b",          function() Snacks.picker.grep_buffers() end,       desc = "Grep: Buffer Lines" },
  { "<C-s>g",          function() Snacks.picker.grep() end,               desc = "Grep: Global Lines" },
  { "<C-s>/",          function() Snacks.picker.lines() end,              desc = "Grep: Lines" },
  { "<C-s>w",          function() Snacks.picker.grep_word() end,          desc = "Grep: Word Under Cursor", mode = { "n", "x" }, },
  { "<c-/>",           function() Snacks.picker.grep() end,               desc = "Grep: Global Lines" },
  { "<leader>/",       function() Snacks.picker.grep() end,               desc = "Grep: Global Lines" },
  { "<c-_>",           function() Snacks.picker.grep() end,               desc = "Grep: Global Lines" },
  -- diagnostics
  { "<C-s>d", function() Snacks.picker.diagnostics_buffer() end,          desc = "LSP: Diagnostics" },
  { "<C-s>D", function() Snacks.picker.diagnostics() end,                 desc = "LSP: Global Diagnostics" },
  { "<C-s>s", function() Snacks.picker.lsp_symbols() end,                 desc = "LSP: Symbols" },
  { "<C-s>S", function() Snacks.picker.lsp_workspace_symbols() end,       desc = "LSP: Global Symbols" },

  -- lsp
  { "gr", group = "LSP"},
  { "grd", function() Snacks.picker.lsp_definitions() end,                desc = "Definition" },
  { "grD", "<Cmd>Lspsaga peek_definition<CR>",                            desc = "Definition Peeker" },
  { "grt", function() Snacks.picker.lsp_type_definitions() end,           desc = "Type Definition" },
  { "grT", "<Cmd>Lspsaga peek_type_definition<CR>",                       desc = "Type Definition Peeker" },
  { "grr", function() Snacks.picker.lsp_references() end, nowait = true,  desc = "References" },
  { "gri", function() Snacks.picker.lsp_implementations() end,            desc = "Goto Implementation" },
  { "gri", "<cmd>Telescope lsp_incoming_calls<CR>",                       desc = "Calls Incoming" },
  { "gro", "<cmd>Telescope lsp_outgoing_calls<CR>",                       desc = "Calls Outgoing" },
  { "grf", "<Cmd>Lspsaga finder<CR>",                                     desc = "Finder" },
  { "grk", "<cmd>Lspsaga hover_doc ++keep<CR>",                           desc = "Hover Docs+" },

  { "z", group = "UFO" },
  { "zR", "<cmd>lua require('ufo').openAllFolds()<CR>",         desc = "UFO: Open All Folds" },
  { "zM", "<cmd>lua require('ufo').closeAllFolds()<CR>",        desc = "UFO: Close All Folds" },
  { "zr", "<cmd>lua require('ufo').openFoldsExceptKinds()<CR>", desc = "UFO: Open Folds Except Kinds" },
  { "zm", "<cmd>lua require('ufo').closeFoldsWith()<CR>",       desc = "UFO: Close Folds With" },
  {
    "zk",
    function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        -- choose one of coc.nvim and nvim lsp
        vim.fn.CocActionAsync("definitionHover") -- coc.nvim
        vim.lsp.buf.hover()
      end
    end,
    desc = "UFO: Peek Folded Lines or Hover",
  },

  { "<leader>s", group = "Search Lists" },
  -- quick list
  { "<leader>sl", function() Snacks.picker.loclist() end,       desc = "Location Lists" },
  { "<leader>sq", function() Snacks.picker.qflist() end,        desc = "Quickfix Lists" },
  -- to-do
  { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo Lists" },
  {
    "<leader>sT",
    function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end,
    desc = "Todo/Fix/Fixme Lists",
  },



  -- Tools
  { "<C-t>", group = "Tools" },
  { "<C-t>c", function() Snacks.picker.commands() end,         desc = "Tool: Commands" },
  { "<C-t>k", function() Snacks.picker.keymaps() end,          desc = "Tool: Keymaps" },
  { "<C-t>h", function() Snacks.picker.help() end,             desc = "Tool: Help Pages" },
  { "<C-t>u", function() Snacks.picker.undo() end,             desc = "Tool: Undo History" },
  { "<C-t>/", function() Snacks.picker.search_history() end,   desc = "Tool: Search History" },
  { "<C-t>t", ":lua require('nvchad.themes').open()<cr>",      desc = "Tool: Theme" },
  { "<C-t>:", function() Snacks.picker.command_history() end,  desc = "Picker: Command History" },
  { "<C-t>l", "<Cmd>Lazy<CR>",                                 desc = "Tool: Lazy" },

  -- Git from Snacks
  { "<c-g>", group = "Git" },
  -- Search
  { "<c-g>s", group = "Git Search" },
  { "<c-g>sl", function() Snacks.picker.git_log() end,         desc = "Git Log" },
  { "<c-g>sL", function() Snacks.picker.git_log_line() end,    desc = "Git Log Line" },
  { "<c-g>sf", function() Snacks.picker.git_log_file() end,    desc = "Git Log File" },
  { "<c-g>sd", function() Snacks.picker.git_diff() end,        desc = "All Diff Hunks" },
  { "<c-g>ss", function() Snacks.picker.git_status() end,      desc = "Git Status" },
  { "<c-g>sb", function() Snacks.picker.git_branches() end,    desc = "Branches" },

  { "<c-g>t", group = "Toggle" },
  { "<c-g>td", "<Cmd>Gitsigns toggle_deleted<CR>",             desc = "Toggle Deleted" },
  { "<c-g>tb", "<Cmd>Gitsigns toggle_current_line_blame<CR>",  desc = "Toggle Blame" },
  { "<c-g>tw", "<Cmd>Gitsigns toggle_word_diff<CR>",           desc = "Toggle Word diff" },
  { "<c-g>tl", "<Cmd>Gitsigns toggle_linehl<CR>",              desc = "Toggle Line Highlight" },
  { "<c-g>tn", "<Cmd>Gitsigns toggle_numhl<CR>",               desc = "Toggle Line Num Highlight" },
  -- hunks
  { "<c-g>h", "<Cmd>Gitsigns stage_hunk<CR>",                  desc = "Hunk: Stage" },
  { "<c-g>H", "<Cmd>Gitsigns undo_stage_hunk<CR>",             desc = "Hunk: Unstage" },
  { "<c-g>S", "<Cmd>Gitsigns select_hunk<CR>",                 desc = "Hunk: Select" },
  -- buffer
  { "<c-g>b", "<Cmd>Gitsigns stage_buffer<CR>",                desc = "Buffer: Stage" },
  { "<c-g>B", "<Cmd>Gitsigns reset_buffer_index<CR>",          desc = "Buffer: Unstage" },
  -- diff preview
  { "<c-g>p", "<Cmd>Gitsigns preview_hunk<CR>",                desc = "Diff: Hunk" },
  { "<c-g>P", "<Cmd>Gitsigns preview_hunk_inline<CR>",         desc = "Diff: Hunk Inline" },
  -- diffview
  { "<c-g>d", "<Cmd>Gdiffsplit!<CR>",                          desc = "Diff: Split" },
  -- reset
  { "<c-g>r", "<Cmd>Gitsigns reset_hunk<CR>",                  desc = "Reset: Hunk" },
  { "<c-g>R", "<Cmd>Gitsigns reset_buffer<CR>",                desc = "Reset: Buffer" },
  {
    "]c",
    function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function() require("gitsigns").next_hunk() end)
      return "<Ignore>"
    end,

    desc = "Git: Next gitsigns hunk",
  },
  {
    "[c",
    function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function() require("gitsigns").prev_hunk() end)
      return "<Ignore>"
    end,
    desc = "Git: Previous gitsigns hunk",
  },

  -- avante
  { "<leader>a", group = "avante" },

  -- makrs
  { "<Leader>m", group = "Marks" },
  { "<Leader>mi", "<Plug>(Marks-delete)", desc = "Delete Marks Input: <input>" },
  { "<Leader>md", "<Plug>(Marks-deleteline)", desc = "Delete Marks In Current Line" },
  { "<Leader>mA", "<Cmd>delmarks a-zA-Z0-9<CR>", desc = "Delete All Marks" },
  { "<Leader>mb", "<Cmd>MarksListBuf<CR>", desc = "Buffer Marks" },
  { "<Leader>mB", "<Plug>(Marks-deletebuf)", desc = "Delete Current Buffer Marks" },
  -- { "<Leader>ml'", proxy = "<leader>s'", desc = "List Marks" },

  { "mm", "<Plug>(Marks-setnext)", desc = "Marks SetNext" },
})

-- bufferline
wk.add({
  { ",", group = "BufferLine" },
  { ",,", function() Snacks.picker.buffers() end, desc = "Buffers" },
  { ",p", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
  { ",bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers in the Right" },
  { ",bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers in the Left" },

  -- Native support since Neovim 0.11
  { "<S-h>", "<Cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
  { "<S-l>", "<Cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },

  -- tabs
  { "[t", ":tabprevious<CR>", desc = "Go to previous tab" },
  { "]t", ":tabnext<CR>", desc = "Go to next tab" },
})
for i = 1, 9 do
  wk.add({
    "," .. i,
    "<Cmd>BufferLineGoToBuffer " .. i .. "<CR>",
    desc = "Go to BufferLine " .. i .. " ",
    hidden = true,
  })
end

-- harpoon2
wk.add({
  { ";h", group = "Harpoon2" },
  { ";ha", function() require("harpoon"):list():add() end, desc = "Harpoon File" },
  {
    ";hh",
    function()
      local harpoon = require("harpoon")
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = "Harpoon Quick Menu",
  },
})
for i = 1, 9 do
  wk.add({
    ";h" .. i,
    function() require("harpoon"):list():select(i) end,
    desc = "Harpoon to File " .. i,
  })
end

pluginKeys.rustaceanvim = function(_, _)
  wk.add({
    mode = "n",
    { "<space>r", group = "Rust" },
    { "<space>rh", ":RustLsp hover actions<CR>", desc = "Hover Action" },
    { "<space>rE", ":RustLsp expandMacro<CR>", desc = "Expand Macro" },
    { "<space>re", ":RustLsp explainError<CR>", desc = "Explain Error" },
    { "<space>rp", ":RustLsp parentModule<CR>", desc = "Parent Module" },
    { "<space>rd", ":RustLsp renderDiagnostic<CR>", desc = "Render Diagnostics" },
    { "<space>ro", ":RustLsp openDocs<CR>", desc = "Open docs.rs" },
    { "<space>rj", ":RustLsp joinLines<CR>", desc = "Join lines" },
    { "<space>rm", ":RustLsp view mir<CR>", desc = "MIR" },
    { "<space>rM", ":RustLsp view hir<CR>", desc = "HIR" },
    { "<space>rc", ":RustLsp openCargo<CR>", desc = "Cargo.toml" },
    { "<space>rr", ":RustLsp runnables ", desc = "Run With Args" },
  })
end

wk.add({
    { "<space>d", group = "Dap" },
})
pluginKeys.dap_mapping = function(dap, dap_ui_widgets, get_args)
  wk.add({
    { "<space>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<space>db", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<space>dc", function() dap.continue() end, desc = "Run/Continue" },
    { "<space>da", function() dap.continue({ before = get_args }) end, desc = "Run with Args" },
    { "<space>dC", function() dap.run_to_cursor() end, desc = "Run to Cursor" },
    { "<space>dg", function() dap.goto_() end, desc = "Go to Line (No Execute)" },
    { "<space>di", function() dap.step_into() end, desc = "Step Into" },
    { "<space>dj", function() dap.down() end, desc = "Down" },
    { "<space>dk", function() dap.up() end, desc = "Up" },
    { "<space>dl", function() dap.run_last() end, desc = "Run Last" },
    { "<space>do", function() dap.step_out() end, desc = "Step Out" },
    { "<space>dO", function() dap.step_over() end, desc = "Step Over" },
    { "<space>dP", function() dap.pause() end, desc = "Pause" },
    { "<space>dr", function() dap.repl.toggle() end, desc = "Toggle REPL" },
    { "<space>ds", function() dap.session() end, desc = "Session" },
    { "<space>dt", function() dap.terminate() end, desc = "Terminate" },
    { "<space>dw", function() dap_ui_widgets.hover() end, desc = "Widgets" },
  })
end

-- For LSP saga
pluginKeys.lspsaga_finder_keys = {
  shuttle = "[w",
  toggle_or_open = { "e", "<CR>" },
  vsplit = "v",
  split = "s",
  tabe = "t",
  tabnew = "T",
  quit = "q",
  close = "<ESC>",
}
pluginKeys.lspsaga_code_action_keys = {
  -- string | table type
  quit = { "q", "<ESC>" },
  exec = "<CR>",
}
pluginKeys.lspsaga_definition_keys = {
  edit = { "e", "<CR>" },
  vsplit = "v",
  split = "s",
  tabe = "t",
  quit = "q",
}
pluginKeys.lspsaga_callhierarchy_keys = {
  edit = { "e", "<CR>" },
  vsplit = "v",
  split = "s",
  tabe = "t",
  quit = "q",
  shuttle = "[w",
  toggle_or_req = "u",
  close = "<ESC>",
}
pluginKeys.lspsaga_diagnostic_keys = {
  exec_action = "<CR>",
  quit = { "q", "<ESC>" },
}
pluginKeys.lspsaga_rename_keys = {
  exec = "<CR>",
  quit = "<ESC>",
}

-- cmp
pluginKeys.cmp_mapping = function(cmp, auto_select)
  return {
    ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
    ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = function(fallback)
      cmp.abort()
      fallback()
    end,
    ["<S-Tab>"] = cmp.mapping(function()
      if vim.snippet.active({ direction = -1 }) then
        vim.schedule(function() vim.snippet.jump(-1) end)
        return
      end
      return "<C-p>"
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function()
      if vim.snippet.active({ direction = 1 }) then
        vim.schedule(function() vim.snippet.jump(1) end)
        return
      end
      return "<C-n>"
    end, { "i", "s" }),
  }
end

-- For trouble
pluginKeys.trouble_action_keys = {
  -- key mappings for actions in the trouble list
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
  -- hover = "K", -- opens a small popup with the full multiline message
  preview = "p", -- preview the diagnostic location
  close_folds = { "Z" }, -- close all folds
  open_folds = { "z" }, -- open all folds
  toggle_fold = { "zA", "za" }, -- toggle fold of current file
  previous = "k", -- previous item
  next = "j", -- next item
}
pluginKeys.trouble_mapping = function()
  -- Lua
  wk.add({
    mode = "n",
    name = "Trouble",
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  })
end
-- stylua: ignore end

return pluginKeys
