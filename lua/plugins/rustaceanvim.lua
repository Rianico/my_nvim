return {
  "mrcjkb/rustaceanvim",
  version = "^5", -- Recommended
  lazy = true,
  ft = { "rust" },
  opts = {
    server = {
      on_attach = function(client, bufnr) require("keybindings").rustaceanvim(client, bufnr) end,
      default_settings = {
        -- rust-analyzer language server configuration
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          -- Add clippy lints for Rust if using rust-analyzer
          -- todo: migrate to clippy
          checkOnSave = true,
          -- Enable diagnostics if using rust-analyzer
          diagnostics = {
            enable = true,
          },
          procMacro = {
            enable = true,
            ignored = {
              ["async-trait"] = { "async_trait" },
              ["napi-derive"] = { "napi" },
              ["async-recursion"] = { "async_recursion" },
            },
          },
          files = {
            excludeDirs = {
              ".direnv",
              ".git",
              ".github",
              ".gitlab",
              "bin",
              "node_modules",
              "target",
              "venv",
              ".venv",
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    local package_path = require("mason-registry").get_package("codelldb"):get_install_path()
    local codelldb = package_path .. "/extension/adapter/codelldb"
    local library_path = package_path .. "/extension/lldb/lib/liblldb.dylib"
    local uname = io.popen("uname"):read("*l")
    if uname == "Linux" then
      library_path = package_path .. "/extension/lldb/lib/liblldb.so"
    end
    opts.dap = {
      adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
    }
    vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    if vim.fn.executable("rust-analyzer") == 0 then
      vim.notify(
        "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
        "error",
        { title = "rustaceanvim" }
      )
    end
  end,
}
