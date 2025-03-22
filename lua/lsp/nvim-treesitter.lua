require("nvim-treesitter.configs").setup({
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = {
    "bash",
    "c",
    "diff",
    "html",
    "go",
    "gomod",
    "gowork",
    "gosum",
    "java",
    "json",
    "jsonc",
    "lua",
    "luadoc",
    "luap",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "rust",
    "ron",
    "sql",
    "scala",
    "regex",
    "slint",
    "toml",
    "vim",
    "yaml",
    -- python
    "ninja",
    "rst",
  },
  highlight = { enable = true },
  indent = { enable = true },
  -- 启用增量选择
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
      goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
    },
  },
})
-- 开启 Folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
vim.wo.foldlevel = 99
-- change rainbow
vim.cmd([[ autocmd FileType * highlight rainbowcol4 guifg=#FF7B72 gui=bold ]])
