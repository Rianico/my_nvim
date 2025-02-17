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

--terminal
map("t", "<esc>", [[<C-n>]], opt)

-- window
-- <C-w>x, exchange with other window
-- <C-w>r, rotate current window
map({ "t", "n" }, "<C-h>", [[<Cmd>wincmd h<CR>]], opt)
map({ "t", "n" }, "<C-j>", [[<Cmd>wincmd j<CR>]], opt)
map({ "t", "n" }, "<C-k>", [[<Cmd>wincmd k<CR>]], opt)
map({ "t", "n" }, "<C-l>", [[<Cmd>wincmd l<CR>]], opt)

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
  preset = "classic", -- "classic" | "modern" | "helix"
  win = {
    no_overlap = false,
    border = "single", -- none, single, double, shadow
    -- position = "bottom", -- bottom, top
    height = { min = 4, max = 25 },
  },
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

-- Zen Mode
map("n", "<Leader>z", "<Cmd>ZenMode<CR>", opt)

pluginKeys = {
  snacks = {},
}
wk.add({
  -- Top Pickers & Explorer
  { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
  { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
  { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
  { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },

  -- find
  { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
  { "<C-p>", function() Snacks.picker.files() end, desc = "Find Files" },
  { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
  { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
  { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },

  -- grep
  { "<leader>sb", function() Snacks.picker.lines() end, desc = "Grep Buffer Lines" },
  { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Opened Buffers Line" },
  { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
  { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

  -- diagnostics
  { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
  { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },

  -- lsp
  { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
  { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
  { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
  { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
  { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
  { "gs", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
  { "gS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

  -- quick list
  { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
  { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },

  -- todo: <C-r> replace which-key
  { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
  { "<leader>s'", function() Snacks.picker.marks() end, desc = "Marks" },
  { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
  { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
  { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
  { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
  { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
  { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
  { "<C-r>", function() Snacks.picker.resume() end, desc = "Resume", mode = { "n", "v" } },
  { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },

  -- Git from Snacks
  { "<leader>g", group = "Git" },
  { "<leader>gB", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
  { "<leader>gb", "<Cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Git Blame" },
  { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
  { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
  { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
  { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
  { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
  -- extend Gitsigns
  { "<leader>gD", "<Cmd>Gitsigns toggle_deleted<CR>", desc = "Git Toggle Deleted" },
  { "<leader>gh", "<Cmd>Gitsigns stage_hunk<CR>", desc = "Git Stage Hunk" },
  { "<leader>gH", "<Cmd>Gitsigns undo_stage_hunk<CR>", desc = "Git Unstage Hunk" },
  { "<leader>gr", "<Cmd>Gitsigns reset_hunk<CR>", desc = "Git Reset Hunk" },
  { "<leader>gR", "<Cmd>Gitsigns reset_buffer<CR>", desc = "Git Reset Buffer" },
})

wk.register({

  -- telescope
  ["<Leader>f"] = {
    name = "Files",
    f = { "<Cmd>Telescope current_buffer_fuzzy_find<CR>", "Grep Current Buffer" },
    g = { "<Cmd>Telescope live_grep<CR>", "Live Grep" },
    s = { "<cmd>Telescope grep_string<CR>", "Grep String" },
    E = { ":lua MiniFiles.open()<CR>", "File Explorer" },
    -- <C-q> Send all items not filtered to quickfixlist (qflist)
    -- M-q Send all selected items to qflist
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
    d = { "<Plug>(Marks-delete)", "Delete Marks Input: <input>" },
    l = { "<Plug>(Marks-deleteline)", "Delete Marks In Current Line" },
    D = { "<Plug>(Marks-deletebuf)", "Delete Marks In Current Buffer" },
    A = { "<Cmd>delmarks a-zA-Z0-9<CR>", "Delete All Marks" },
    b = { "<Cmd>MarksListBuf<CR>", "Buffer Marks" },
    m = { "<Cmd>Telescope marks<CR>", "Telescope Marks" },
  },
  ["m"] = {
    name = "Marks",
    m = { "<Plug>(Marks-setnext)", "Marks SetNext" },
  },

  -- leap
  ["<Leader>s"] = {
    name = "Leap",
    -- s<space><space> jump to the line
    s = { "<Plug>(leap-forward)", "Leap Forward", modes = { "n", "x", "o" } },
    S = { "<Plug>(leap-backward)", "Leap Backward", modes = { "n", "x", "o" } },
    W = { "<Plug>(leap-from-window)", "Leap Across Window", modes = { "n" } },
  },

  -- toggleterm
  ["<Leader>t"] = {
    name = "ToggleTerm",
    -- <C-\> ToggleTerm
    t = { "<Cmd>ToggleTerm direction=horizontal<CR>", "Horizontal Terminal" },
    v = { "<Cmd>ToggleTerm direction=vertical<CR>", "Vertical VTerminal" },
  },
})

-- gitsigns
local gs = require("gitsigns")
map("n", "]c", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function() gs.next_hunk() end)
  return "<Ignore>"
end, { expr = true })
map("n", "[c", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function() gs.prev_hunk() end)
  return "<Ignore>"
end, { expr = true })

-- general lsp keybindings based on vim.lsp
pluginKeys.default_on_attach = function(_, _)
  wk.add({
    mod = "n",
    {
      "gi",
      vim.lsp.buf.implementation,
      desc = "Go to the implementation",
    },
    { "<Space>w", group = "Workspace" },
    { "<space>wa", vim.lsp.buf.add_workspace_folder, desc = "Workspace Add Folder" },
    { "<space>wr", vim.lsp.buf.remove_workspace_folder, desc = "Workspace Remove Folder" },
    {
      "<space>wl",
      function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      desc = "Workspace List",
    },
  })
end

pluginKeys.rustaceanvim = function(client, bufnr)
  pluginKeys.default_on_attach(client, bufnr)
  wk.add({
    mod = "n",
    { "<Space>r", group = "Rust" },
    { "<Space>rh", ":RustLsp hover actions<CR>", desc = "Rust Hover Action" },
    { "<Space>re", ":RustLsp expandMacro<CR>", desc = "Rust Expand Macro" },
    { "<Space>rp", ":RustLsp parentModule<CR>", desc = "Rust Parent Module" },
  })
end

pluginKeys.dap_mapping = function(dap, dapui)
  wk.add({
    mod = "n",
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
  -- map("n", "<space>db", dap.toggle_breakpoint, { desc = "" }, opt)
  -- Eval var under cursor
end

-- For LSP
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opt)
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
pluginKeys.lspsaga_mapping = function()
  wk.add({
    mod = "n",
    { "gf", "<Cmd>Lspsaga finder<CR>", desc = "Code Action: Find ref" },
    {
      "gd",
      "<Cmd>Lspsaga peek_definition<CR>",
      desc = "Code Actions: Definition",
    },
    { "gD", "<Cmd>Lspsaga goto_type_definition<CR>", desc = "Code Actions: Type Definition" },
    { "gr", "<Cmd>Lspsaga rename ++project<CR>", desc = "Code Actions: Rename" },
    { "<Space>l", group = "Lsp" },
    { "<Space>ll", "<cmd>Lspsaga code_action<CR>", desc = "code actions" },
    { "<Space>ls", "<cmd>Lspsaga outline<CR>", desc = "code outline" },
    { "<Space>li", "<cmd>Telescope lsp_incoming_calls<CR>", desc = "incoming calls" },
    { "<Space>lo", "<cmd>Telescope lsp_outgoing_calls<CR>", desc = "outgoing calls" },
    { "<Space>lk", "<cmd>Lspsaga hover_doc ++keep<CR>", desc = "hover docs" },
    { "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "jump to prev diagnostic" },
    { "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", desc = "jump to next diagnostic" },
    {
      "[D",
      function() require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
      desc = "jump to prev error",
    },
    {
      "]D",
      function() require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
      desc = "jump to next error",
    },
  })
end
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

-- For cmp
pluginKeys.cmp_mapping = function(cmp, auto_select, M)
  return {
    ["<CR>"] = M.confirm({ select = auto_select }),
    ["<S-CR>"] = M.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   local col = vim.fn.col(".") - 1
    --   if cmp.visible() then
    --     cmp.select_next_item(select_opts)
    --   elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    --     fallback()
    --   else
    --     cmp.complete()
    --   end
    -- end, { "i", "s" }),
    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item(select_opts)
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
    -- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    -- ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
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
