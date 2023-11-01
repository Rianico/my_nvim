local status, null_ls = pcall(require, "null-ls")
if not status then
    vim.notify("null-ls not found")
    return
end

-- more info: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    sources = {
        -- rust
        formatting.rustfmt.with({
            extra_args = function(params)
                local Path = require("plenary.path")
                local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

                if cargo_toml:exists() and cargo_toml:is_file() then
                    for _, line in ipairs(cargo_toml:readlines()) do
                        local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
                        if edition then
                            return { "--edition=" .. edition }
                        end
                    end
                end
                -- default edition when we don't find `Cargo.toml` or the `edition` in it.
                return { "--edition=2021" }
            end,
        }),
        --  asm
        formatting.asmfmt,
        -- cmake
        formatting.cmake_format,
        -- "bash", "csh", "ksh", "sh", "zsh"
        formatting.beautysh,
        -- proto
        formatting.buf,
        -- lua
        formatting.lua_format,
        -- toml
        formatting.taplo,
        -- yaml
        formatting.yamlfmt,
        -- json
        formatting.fixjson,
        -- python
        formatting.black.with({ extra_args = { "--fast" } }),
        -- xml
        formatting.xmlformat,
        -- formatting.xmllint,
        -- markdown
        formatting.markdownlint,
        formatting.djlint,

        diagnostics.shellcheck,
    },
})
