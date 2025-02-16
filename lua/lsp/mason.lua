-- https://www.lazyvim.org/extras/lang/scala
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

local util = require("lspconfig/util")

local default_opts = {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

-- the servers that should be automatically installed
local lsp_servers = {
  -- lua
  "lua_ls",
  "clangd",
  "bashls",
  "cmake",
  "dockerls",
  -- go
  "gopls",
  -- "delve",
  -- "gomodifytags",
  -- "impl",
  "jdtls",
  -- toml
  "taplo",
  -- json
  "jsonls",
  -- xml
  "lemminx",
  -- markdown
  -- "marksman",
  -- python
  "ruff",
}

mason.setup()
mason_lspconfig.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  pip = {
    -- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
    upgrade_pip = true,
  },
  ensure_installed = lsp_servers,
  automatic_installation = true,
  handles = {
    function(server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup({ vim.tbl_deep_extend("force", default_opts, {}) })
    end,
  },
})

-- for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
-- You can add custom settings for specific servers here
--     local server_opts = vim.tbl_deep_extend("force", default_opts, {})
--     lspconfig[server_name].setup(server_opts)
-- end

lspconfig.gopls.setup({
  on_attach = function(client, _)
    if client.name == "gopls" and not client.server_capabilities.semanticTokensProvider then
      local semantic = client.config.capabilities.textDocument.semanticTokens
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
        range = true,
      }
    end
  end,
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
    },
  },
})

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

lspconfig.ruff.setup({
  cmd_env = { RUFF_TRACE = "messages" },
  init_options = {
    settings = {
      logLevel = "error",
    },
  },
  on_attach = function(client, _)
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end,
})
