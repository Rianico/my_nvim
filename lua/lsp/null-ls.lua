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
		-- Formatting ---------------------
		--  asm
		formatting.asmfmt,
		-- "c", "cpp", "cs", "java", "cuda"
		formatting.clang_format,
		-- cmake
		formatting.cmake_format,
		-- "bash", "csh", "ksh", "sh", "zsh"
		formatting.beautysh,
		-- proto
		formatting.buf,
		-- lua
		formatting.stylua,
		-- toml
		formatting.taplo,
		-- yaml
		formatting.yamlfmt,
		-- json
		formatting.fixjson,
		-- python
		formatting.black.with({ extra_args = { "--fast" } }),
		-- Fix common misspellings in text files.
		formatting.codespell,

		-- for rust
		formatting.trim_newlines.with({
			disabled_filetypes = { "rust" }, -- use rustfmt
		}),
		formatting.trim_whitespace.with({
			disabled_filetypes = { "rust" }, -- use rustfmt
		}),

		diagnostics.cfn_lint,
	},
})
