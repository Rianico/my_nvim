-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file
local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua", lsp_format = "fallback" },
    go = { "goimports", "gofumpt" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
    slint = { "slintfmt" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    -- Disable autoformat on certain filetypes
    local ignore_filetypes = {}
    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      return
    end
    -- Disable autoformat for files in a certain path
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("/node_modules/") then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})

conform.formatters.stylua = {
  prepend_args = {
    "--indent-type",
    "Spaces",
    "--indent-width",
    "2",
    "--column-width",
    "120",
    "--collapse-simple-statement",
    "FunctionOnly",
  },
}

-- https://rust-lang.github.io/rustfmt/?version=v1.6.0&search=
conform.formatters.rustfmt = {
  prepend_args = {
    "--config",
    table.concat({
      "imports_granularity=Module",
      "newline_style=Auto",
      "group_imports=StdExternalCrate",
      "merge_derives=false",
      "reorder_impl_items=true",
      "where_single_line=true",
      "wrap_comments=true",
      "max_width=161",
    }, ","),
  },
}

conform.formatters.slintfmt = {
  command = "slint-lsp",
  args = { "format", "$FILENAME" },
}

vim.keymap.set("", "<localleader>f", function()
  require("conform").format({ async = true }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
      end
    end
  end)
end, { desc = "Format code" })

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
