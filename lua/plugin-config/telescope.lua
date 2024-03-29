local actions = require("telescope.actions")
local telescope = require("telescope")

-- Custom actions
local transform_mod = require("telescope.actions.mt").transform_mod
local nvb_actions = transform_mod({
	file_path = function(prompt_bufnr)
		-- Get selected entry and the file full path
		local content = require("telescope.actions.state").get_selected_entry()
		local full_path = content.cwd .. require("plenary.path").path.sep .. content.value

		-- Yank the path to unnamed register
		vim.fn.setreg('"', full_path)

		-- Close the popup
		print("File path is yanked ")
		actions.close(prompt_bufnr)
	end,
})

telescope.setup({
	defaults = {},
	pickers = {
		find_files = {
			theme = "ivy",
			results_title = false,
			sorting_strategy = "ascending",

			layout_strategy = "bottom_pane",
			layout_config = {
				height = 20,
			},

			mappings = {
				n = {
					["y"] = nvb_actions.file_path,
				},
				i = {
					["<C-y>"] = nvb_actions.file_path,
				},
			},
		},
		git_files = {
			-- theme = "dropdown",
			mappings = {
				n = {
					["y"] = nvb_actions.file_path,
				},
				i = {
					["<C-y>"] = nvb_actions.file_path,
				},
			},
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("repo")
telescope.load_extension("file_browser")
telescope.load_extension("harpoon")
telescope.load_extension("neoclip")
