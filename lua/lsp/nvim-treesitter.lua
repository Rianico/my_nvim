---@diagnostic disable: missing-fields
require("nvim-treesitter.configs").setup({
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
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  ignore_install = {},
  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  -- Using this option may slow down your editor, and you may see some duplicate highlights.
  -- Instead of true it can also be a list of languages
  additional_vim_regex_highlighting = false,
  highlight = { enable = true },
  indent = { enable = true },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "<CR>",
  --     node_incremental = "<CR>",
  --     node_decremental = "<BS>",
  --     scope_incremental = "<TAB>",
  --   },
  -- },
  -- textobjects = {
  --   move = {
  --     enable = true,
  --     goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
  --     goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
  --     goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
  --     goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
  --   },
  -- },
})
-- 开启 Folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
vim.wo.foldlevel = 99
-- change rainbow
vim.cmd([[ autocmd FileType * highlight rainbowcol4 guifg=#FF7B72 gui=bold ]])
