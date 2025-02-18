return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        {
          section = "terminal",
          cmd = "fortune -s | cowsay",
          hl = "header",
          pane = 2,
          padding = 1,
        },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function() return Snacks.git.get_root() ~= nil end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },
    indent = {
      enabled = true,
      filter = function(buf)
        local exclude = {
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
        }
        return vim.g.snacks_indent ~= false
          and vim.b[buf].snacks_indent ~= false
          and vim.bo[buf].buftype == ""
          and not vim.tbl_contains(exclude, vim.bo[buf].filetype)
      end,
    },
    -- scroll = { enabled = true },
    explorer = { enabled = true },
    picker = { enabled = true },
    -- scope = { enabled = true },

    -- quickfile = { enabled = true },
    -- words = { enabled = true },

    -- use noice
    notifier = { enabled = true },
    input = { enabled = true },
  },
}
