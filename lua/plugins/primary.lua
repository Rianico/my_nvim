return {
  -- Lazy can manage itself
  { "folke/lazy.nvim" },
  -- lsp
  {
    { "williamboman/mason.nvim", version = "v1.11.x" },
    { "williamboman/mason-lspconfig.nvim", version = "v1.32.x" },
    "neovim/nvim-lspconfig",
  },
  -- dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "williamboman/mason.nvim",
    },
    event = { "VeryLazy" },
    lazy = true,
    config = function()
      dofile(vim.g.base46_cache .. "trouble")
    end,
  },
  -- lsp enhanced
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {},
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
    lazy = true,
  },
  { "ray-x/lsp_signature.nvim", after = "nvim-lspconfig" },
  -- Autocompletion framework
  { "hrsh7th/vim-vsnip" },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.3.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt" },
    config = function() end,
    lazy = true,
  },
  -- trouble
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    lazy = true,
    config = function() dofile(vim.g.base46_cache .. "trouble") end,
  },
  -- grammar highlight
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  },
  { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
  -- comment
  { "numToStr/Comment.nvim", event = { "VeryLazy" }, lazy = true },
  -- code formatting
  -- { "nvimtools/none-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },
  -- Leap
  { "ggandor/flit.nvim", dependencies = "ggandor/leap.nvim" },
  -- vista
  { "liuchengxu/vista.vim", lazy = true },
  -- mini.nvim
  { "echasnovski/mini.cursorword" },
  { "echasnovski/mini.pairs" },
  { "echasnovski/mini.ai", branch = "stable" },
  { "echasnovski/mini.icons", branch = "stable" },
  { "echasnovski/mini.surround", branch = "stable" },
  { "echasnovski/mini.files", branch = "stable" },
  -- repeat
  { "tpope/vim-repeat", event = "VeryLazy" },
  -- which key, hint the next shortcut key
  { "folke/which-key.nvim", lazy = true },
  -- marks
  { "chentoast/marks.nvim", lazy = true },
  -- git
  { "lewis6991/gitsigns.nvim", tag = "release", lazy = true },
  -- terminal
  { "akinsho/toggleterm.nvim", tag = "v2.2.1", lazy = true },
  -- zen
  { "folke/zen-mode.nvim", event = "VeryLazy", lazy = true },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "cljoly/telescope-repo.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          actions = require("trouble.sources.snacks").actions,
          win = {
            input = {
              keys = {
                ["<c-t>"] = {
                  "trouble_open",
                  mode = { "n", "i" },
                },
              },
            },
          },
        },
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opt = {},
  },
}
