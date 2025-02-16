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
  defaults = {
    theme = "dropdown",
    layout_config = {
      width = 0.98,
      height = 0.618,
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
      results_title = false,
      sorting_strategy = "ascending",
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
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("repo")
telescope.load_extension("file_browser")
telescope.load_extension("harpoon")
telescope.load_extension("neoclip")
-- telescope.load_extension("noice")
