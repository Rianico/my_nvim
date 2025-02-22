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
-- save and quit
map("n", "<C-s>", ":w<CR>", opt)
map("i", "<C-s>", "<Esc>:w<CR>", opt)
map("n", "<C-q>", ":confirm q<CR>", opt)

local wk = require("which-key")
wk.setup({
  preset = "classic", -- "classic" | "modern" | "helix"
  win = {
    no_overlap = false,
    border = "single", -- none, single, double, shadow
    -- position = "bottom", -- bottom, top
    height = { min = 4, max = 25 },
  },
  sort = { "local", "order", "group", "mod", "alphanum", "desc" },
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
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
})

pluginKeys = {
  snacks = {},
}
wk.add({
  -- Top Pickers & Explorer
  { "<leader><space>", function() Snacks.picker.smart() end, desc = "General: Smart Find Files" },
  { '<leader>"', function() Snacks.picker.registers() end, desc = "General: Registers", hidden = true },
  { "<leader>'", function() Snacks.picker.marks() end, desc = "General: Marks", hidden = true },
  { "<leader>n", function() Snacks.picker.notifications() end, desc = "General: Notification History" },
  { "<leader>e", function() Snacks.explorer() end, desc = "General: File Explorer" },
  { "<c-/>", function() Snacks.picker.grep() end, desc = "General: Grep" },
  {
    "<c-\\>",
    function()
      local shell = vim.fn.executable("zsh") == 1 and "zsh" or "bash"
      return Snacks.terminal.toggle(shell)
    end,
    desc = "Toggle Terminal",
    mode = { "n", "t" },
  },
  { "<c-_>", function() Snacks.picker.grep() end, desc = "General: Grep" },
  { "<leader>z", function() Snacks.zen() end, desc = "Zen mode", hidden = true },

  -- motions
  -- stylua: ignore
  {
    { "s",     function() require("flash").jump() end,              mode = { "n", "x", "o" }, desc = "Flash" },
    { "S",     function() require("flash").treesitter() end,        mode = { "n" },           desc = "Flash Treesitter" },
    { "r",     function() require("flash").remote() end,            mode = "o",               desc = "Remote Flash" },
    { "R",     function() require("flash").treesitter_search() end, mode = { "o", "x" },      desc = "Treesitter Search" },
  },

  -- find
  { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
  { "<C-p>", function() Snacks.picker.files() end, desc = "Find Files" },
  { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
  { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },

  -- grep
  { "<leader>s", group = "search" },
  { "<leader>sb", function() Snacks.picker.lines() end, desc = "Grep: Lines" },
  { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep: Buffers Line" },
  { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep: Global" },
  {
    "<leader>sw",
    function() Snacks.picker.grep_word() end,
    desc = "Grep: Selection or Word",
    mode = { "n", "x" },
  },

  -- diagnostics
  { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "LSP: Buffer Diagnostics" },
  { "<leader>sD", function() Snacks.picker.diagnostics() end, desc = "LSP: Diagnostics" },

  -- lsp
  {
    mode = "n",
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "LSP: Definition" },
    { "gD", "<Cmd>Lspsaga peek_definition<CR>", desc = "LSP: Peek Definition" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "LSP: References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "LSP: Goto Implementation" },
    { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP: Goto Type Definition" },
    { "gT", "<Cmd>Lspsaga peek_type_definition<CR>", desc = "LSP: Goto Type Definition" },
    { "gs", function() Snacks.picker.lsp_symbols() end, desc = "LSP: LSP Symbols" },
    { "gS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP: Workspace Symbols" },
    { "gf", "<Cmd>Lspsaga finder<CR>", desc = "LSP: Find ref" },
    { "gR", "<Cmd>Lspsaga rename ++project<CR>", desc = "LSP: Rename" },

    { "<Space>l", group = "Lsp" },
    { "<Space>ll", "<cmd>Lspsaga code_action<CR>", desc = "LSP: Code Actions" },
    { "<Space>ls", "<cmd>Lspsaga outline<CR>", desc = "LSP: Symbols" },
    { "<Space>li", "<cmd>Telescope lsp_incoming_calls<CR>", desc = "LSP: Incoming Calls" },
    { "<Space>lo", "<cmd>Telescope lsp_outgoing_calls<CR>", desc = "LSP: Outgoing Calls" },
    { "<Space>lk", "<cmd>Lspsaga hover_doc ++keep<CR>", desc = "LSP: Hover Docs" },
    {
      "[d",
      function() require("lspsaga.diagnostic"):goto_prev() end,
      desc = "jump to prev error",
    },
    {
      "]d",
      function() require("lspsaga.diagnostic"):goto_next() end,
      desc = "jump to next error",
    },
    {
      "[e",
      function() require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
      desc = "jump to prev error",
    },
    {
      "]e",
      function() require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
      desc = "jump to next error",
    },
  },

  { "z", group = "UFO" },
  { "zR", "<cmd>lua require('ufo').openAllFolds()<CR>", desc = "UFO: Open All Folds" },
  { "zM", "<cmd>lua require('ufo').closeAllFolds()<CR>", desc = "UFO: Close All Folds" },
  { "zr", "<cmd>lua require('ufo').openFoldsExceptKinds()<CR>", desc = "UFO: Open Folds Except Kinds" },
  { "zm", "<cmd>lua require('ufo').closeFoldsWith()<CR>", desc = "UFO: Close Folds With" },
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

  -- quick list
  { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
  { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },

  { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Tool: Search History" },
  { "<leader>:", function() Snacks.picker.command_history() end, desc = "Tool: Command History" },

  -- Tools
  { "<leader>t", group = "Tools" },
  { "<leader>tc", function() Snacks.picker.commands() end, desc = "Tool: Commands" },
  { "<leader>tk", function() Snacks.picker.keymaps() end, desc = "Tool: Keymaps" },
  { "<leader>th", function() Snacks.picker.help() end, desc = "Tool: Help Pages" },
  { "<leader>tu", function() Snacks.picker.undo() end, desc = "Tool: Undo History" },
  { "<leader>tt", ":lua require('nvchad.themes').open()<cr>", desc = "Tool: Theme" },

  -- Git from Snacks
  { "<c-g>", group = "Git" },
  -- Search
  { "<c-g>s", group = "Git Search" },
  { "<c-g>sl", function() Snacks.picker.git_log() end, desc = "Git Log" },
  { "<c-g>sL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
  { "<c-g>sf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
  { "<c-g>sd", function() Snacks.picker.git_diff() end, desc = "All Diff Hunks" },
  { "<c-g>ss", function() Snacks.picker.git_status() end, desc = "Git Status" },
  { "<c-g>sb", function() Snacks.picker.git_branches() end, desc = "Branches" },

  { "<c-g>t", group = "Toggle" },
  { "<c-g>td", "<Cmd>Gitsigns toggle_deleted<CR>", desc = "Toggle Deleted" },
  { "<c-g>tb", "<Cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle Blame" },
  { "<c-g>tw", "<Cmd>Gitsigns toggle_word_diff<CR>", desc = "Toggle Word diff" },
  { "<c-g>tl", "<Cmd>Gitsigns toggle_linehl<CR>", desc = "Toggle Line Highlight" },
  { "<c-g>tn", "<Cmd>Gitsigns toggle_numhl<CR>", desc = "Toggle Line Num Highlight" },

  -- hunks
  { "<c-g>g", "<Cmd>Gitsigns stage_hunk<CR>", desc = "Hunk: Stage" },
  { "<c-g>h", "<Cmd>Gitsigns undo_stage_hunk<CR>", desc = "Hunk: Unstage" },
  { "<c-g>r", "<Cmd>Gitsigns reset_hunk<CR>", desc = "Hunk: Reset" },
  { "<c-g>P", "<Cmd>Gitsigns preview_hunk_inline<CR>", desc = "Hunk: Preview Inline" },
  { "<c-g>p", "<Cmd>Gitsigns preview_hunk<CR>", desc = "Hunk: Preview" },
  { "<c-g>S", "<Cmd>Gitsigns select_hunk<CR>", desc = "Hunk: Select" },
  -- buffer
  { "<c-g>R", "<Cmd>Gitsigns reset_buffer<CR>", desc = "Buffer: Reset" },
  { "<c-g>a", "<Cmd>Gitsigns stage_buffer<CR>", desc = "Buffer: Stage" },
  { "<c-g>d", "<Cmd>Gitsigns diffthis ~<CR>", desc = "Buffer: Diff This" },
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

  -- mini.surrounding
  { "gz", "", desc = "+surround" },
  -- avante
  { "<leader>a", group = "avante" },

  -- bufferline
  { ";", group = "BufferLine" },
  { ";1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to Buffer 1 in BufferLine", hidden = true },
  { ";2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to Buffer 2 in BufferLine", hidden = true },
  { ";3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to Buffer 3 in BufferLine", hidden = true },
  { ";4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to Buffer 4 in BufferLine", hidden = true },
  { ";5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to Buffer 5 in BufferLine", hidden = true },
  { ";6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to Buffer 6 in BufferLine", hidden = true },
  { ";7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to Buffer 7 in BufferLine", hidden = true },
  { ";8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to Buffer 8 in BufferLine", hidden = true },
  { ";;", function() Snacks.picker.buffers() end, desc = "Buffers" },
  { ";p", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
  { ";cl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers in the Right" },
  { ";ch", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers in the Left" },

  { "[b", "<Cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer", hidden = true },
  { "]b", "<Cmd>BufferLineCycleNext<cr>", desc = "Next Buffer", hidden = true },
  { "[B", "<Cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev", hidden = true },
  { "]B", "<Cmd>BufferLineMoveNext<cr>", desc = "Move buffer next", hidden = true },
  { "<S-h>", "<Cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
  { "<S-l>", "<Cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },

  -- tabs
  { "[t", ":tabprevious<CR>", desc = "Go to previous tab" },
  { "]t", ":tabnext<CR>", desc = "Go to next tab" },

  -- todo
  { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
  {
    "<leader>sT",
    function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end,
    desc = "Todo/Fix/Fixme",
  },

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
    { "<Space>r", group = "Rust" },
    { "<Space>rh", ":RustLsp hover actions<CR>", desc = "Hover Action" },
    { "K", ":RustLsp hover actions<CR>", desc = "Hover Action" },
    { "<Space>rE", ":RustLsp expandMacro<CR>", desc = "Expand Macro" },
    { "<Space>re", ":RustLsp explainError<CR>", desc = "Explain Error" },
    { "<Space>rp", ":RustLsp parentModule<CR>", desc = "Parent Module" },
    { "<Space>rd", ":RustLsp renderDiagnostic<CR>", desc = "Render Diagnostics" },
    { "<Space>ro", ":RustLsp openDocs<CR>", desc = "Open docs.rs" },
    { "<Space>rj", ":RustLsp joinLines<CR>", desc = "Join lines" },
    { "<Space>rm", ":RustLsp view mir<CR>", desc = "MIR" },
    { "<Space>rM", ":RustLsp view hir<CR>", desc = "HIR" },
    { "<Space>rc", ":RustLsp openCargo<CR>", desc = "Cargo.toml" },
    { "<Space>rr", ":RustLsp runnables ", desc = "Run With Args" },
  })
end

pluginKeys.dap_mapping = function(dap, dapui)
  wk.add({
    mode = "n",
    { "<space>d", group = "Dap" },
    { "<space>db", dap.toggle_breakpoint, desc = "Dap Toggle Breakpoint" },
    { "<space>dl", dap.list_breakpoints, desc = "Dap List Breakpoints" },
    { "<space>dC", dap.run_to_cursor, desc = "Dap Run To Cursor" },
    { "<space>dc", dap.continue, desc = "Dap Continue" },
    { "<f7>", dap.step_into, desc = "Dap Step Into" },
    { "<f8>", dap.step_over, desc = "Dap Step Over" },
    { "<f20>", dap.step_out, desc = "Dap Step Out" },
    { "<space>dr", dap.restart, desc = "Dap Restart" },
    { "<space>dx", dap.terminate, desc = "Dap Terminated" },
    {
      "<space>de",
      function() dapui.eval(nil, { enter = true }) end,
      desc = "Dap Eval Value",
    },
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

return pluginKeys
