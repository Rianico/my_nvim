local null_ls = require("null-ls")

-- more info: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local slintfmt = {
	method = null_ls.methods.FORMATTING,
	filetypes = { "slint" },
	-- null_ls.generator creates an async source
	-- that spawns the command with the given arguments and options
	generator = null_ls.generator({
		command = "slint-lsp",
		-- args = { "--stdin" },
		to_stdin = true,
		from_stderr = true,
		-- choose an output format (raw, json, or line)
		format = "line",
		check_exit_code = function(code, stderr)
			local success = code <= 1
			if not success then
				-- can be noisy for things that run often (e.g. diagnostics), but can
				-- be useful for things that run on demand (e.g. formatting)
				print(stderr)
			end
			return success
		end,
		on_output = function(_, _) end,
	}),
}

-- require install rustfmt in local
local rustfmt = {
	method = null_ls.methods.FORMATTING,
	filetypes = { "rust" },
	-- null_ls.generator creates an async source
	-- that spawns the command with the given arguments and options
	generator = null_ls.generator({
		command = "rustfmt",
		-- args = { "--stdin" },
		to_stdin = true,
		from_stderr = true,
		-- choose an output format (raw, json, or line)
		format = "line",
		check_exit_code = function(code, stderr)
			local success = code <= 1
			if not success then
				-- can be noisy for things that run often (e.g. diagnostics), but can
				-- be useful for things that run on demand (e.g. formatting)
				print(stderr)
			end
			return success
		end,
		on_output = function(_, _) end,
	}),
}

null_ls.register({ slintfmt, rustfmt })

null_ls.setup({
	debug = false,
	sources = {
		-- lua
		formatting.stylua,
		--  asm
		formatting.asmfmt,
		-- cmake
		formatting.cmake_format,
		-- toml
		-- yaml
		formatting.yamlfmt,
		-- python
		formatting.black.with({ extra_args = { "--fast" } }),
		-- formatting.xmllint,
		-- markdown
		formatting.markdownlint,
		formatting.djlint,
		-- go
		formatting.gofmt,
		-- cmake
		diagnostics.cmake_lint,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})

-- require("lsp.formatting").configure_format_on_save()
