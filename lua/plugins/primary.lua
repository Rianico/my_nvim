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
  { "folke/trouble.nvim", dependencies = "kyazdani42/nvim-web-devicons", lazy = true },
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
  -- status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
  },
  -- bufferline
  { "akinsho/bufferline.nvim", tag = "v4.9.1", dependencies = "nvim-tree/nvim-web-devicons" },
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
  -- colorizer
  { "norcalli/nvim-colorizer.lua" },
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
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader>H",
          function() require("harpoon"):list():add() end,
          desc = "Harpoon File",
        },
        {
          "<leader>h",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function() require("harpoon"):list():select(i) end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },
}
