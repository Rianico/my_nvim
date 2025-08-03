---@diagnostic disable: unused-local
return {
  -- Lazy can manage itself
  { "folke/lazy.nvim" },
  -- lsp
  {
    { "williamboman/mason.nvim", version = "v1.11.x" },
    { "williamboman/mason-lspconfig.nvim", version = "v1.32.x" },
    "neovim/nvim-lspconfig",
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
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    },
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
    lazy = vim.fn.argc(-1) == 0, -- Load treesitter early when opening a file from the cmdline
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  },
  { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
  -- comment
  { "numToStr/Comment.nvim", event = { "VeryLazy" }, lazy = true },
  -- mini.nvim
  { "echasnovski/mini.cursorword" },
  { "echasnovski/mini.pairs" },
  { "echasnovski/mini.ai", branch = "stable" },
  -- repeat
  { "tpope/vim-repeat", event = "VeryLazy" },
  -- which key, hint the next shortcut key
  { "folke/which-key.nvim", lazy = true },
  -- marks
  { "chentoast/marks.nvim", lazy = true },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opt = {},
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      jump = {
        autojump = true,
      },
      modes = {
        char = {
          jump_labels = true,
          multi_line = false,
        },
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    --[[
        Old text                    Command         New text
    --------------------------------------------------------------------------------
        surr*ound_words             ysiw)           (surround_words)
        *make strings               ys$"            "make strings"
        [delete ar*ound me!]        ds]             delete around me!
        remove <b>HTML t*ags</b>    dst             remove HTML tags
        'change quot*es'            cs'"            "change quotes"
        <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
        delete(functi*on calls)     dsf             function calls
    --]]
    config = function() require("nvim-surround").setup({}) end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype) return { "lsp", "indent" } end,
      })
    end,
  },
}
