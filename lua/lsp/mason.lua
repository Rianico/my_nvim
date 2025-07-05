-- https://www.lazyvim.org/extras/lang/scala
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local default_opts = {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
}
default_opts.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- The servers that should be automatically installed
local lsp_servers = {
  -- lua
  "lua_ls",
  "clangd",
  "bashls",
  "cmake",
  "dockerls",
  -- go
  "gopls",
  "harper_ls",
  "jdtls",
  "slint_lsp",
  -- toml
  "taplo",
  -- json
  "jsonls",
  -- xml
  "lemminx",
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
  automatic_enable = true,
  handles = {
    function(server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup({ vim.tbl_deep_extend("force", default_opts, {}) })
    end,
  },
})

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
lspconfig.pylsp.setup({})

-- enable slint files recognization
vim.cmd([[ autocmd BufEnter *.slint :setlocal filetype=slint ]])
lspconfig.slint_lsp.setup({
  command = { "slint-lsp" },
  highlightingModeRegex = "slint",
})

lspconfig.taplo.setup({})

lspconfig.bashls.setup({
  filetypes = { "sh", "bash", "zsh" },
})

lspconfig.harper_ls.setup({
  settings = {
    ["harper-ls"] = {
      linters = {
        SentenceCapitalization = false,
        SpellCheck = false,
      },
    },
  },
})

lspconfig.asm_lsp.setup({})
