-- https://www.lazyvim.org/extras/lang/scala

-- vim.pack.add({
--   { src = "https://github.com/neovim/nvim-lspconfig" },
--   { src = "https://github.com/mason-org/mason.nvim" },
--   { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
--   { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
--   { src = "https://github.com/L3MoN4D3/LuaSnip" },
-- })

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
  "stylua",
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
  "pylsp",
  "ruff",
  "pyflakes",
}

require("mason").setup()
require("mason-lspconfig").setup({
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
  automatic_installation = true,
  automatic_enable = true,
})
require("mason-tool-installer").setup({
  ensure_installed = lsp_servers
})


vim.lsp.config.gopls = {
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
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
  root_markers = { "go.mod", "go.work", ".git" },
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
}

vim.lsp.config.lua_ls = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim", "require" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
    },
  },
}

vim.lsp.config.ruff = {
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
}

-- enable slint files recognization
vim.cmd([[ autocmd BufEnter *.slint :setlocal filetype=slint ]])
vim.lsp.config.slint_lsp = {
  command = { "slint-lsp" },
  highlightingModeRegex = "slint",
}

vim.lsp.config.bashls = {
  filetypes = { "sh", "bash", "zsh" },
}

vim.lsp.config("harper-ls", {
  settings = {
    ["harper-ls"] = {
      linters = {
        SentenceCapitalization = false,
        SpellCheck = false,
      },
    },
  },
})

vim.lsp.enable({
  "pylsp",
  "taplo",
  "asm_lsp",
  "bashls",
  "harper-ls",
  "slint_lsp",
  "lua_ls",
  "gopls",
})

require("luasnip.loaders.from_vscode").lazy_load()
