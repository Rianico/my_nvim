local M = {}

-- Find a file either using git files or search the filesystem.
function M.find_files()
	local opts = {}
	---@diagnostic disable-next-line: redefined-local
	local builtin = require("telescope.builtin")

	local ok = pcall(builtin.git_files, opts)
	if not ok then
		builtin.find_files(opts)
	end
end

-- Custom find buffers function.
function M.find_buffers()
	local results = {}
	local buffers = vim.api.nvim_list_bufs()

	for _, buffer in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buffer) then
			local filename = vim.api.nvim_buf_get_name(buffer)
			table.insert(results, filename)
		end
	end

	vim.ui.select(results, { prompt = "Find buffer:" }, function(selected)
		if selected then
			vim.api.nvim_command("buffer " .. selected)
		end
	end)
end

return M
