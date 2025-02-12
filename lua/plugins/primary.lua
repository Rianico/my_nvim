return {
	-- speedup nvim
	{ "lewis6991/impatient.nvim" },
	-- Lazy can manage itself
	{ "folke/lazy.nvim" },
	-- lsp
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	-- dap
	{
		"mfussenegger/nvim-dap",
		tag = "0.8.0",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"williamboman/mason.nvim",
		},
	},
	-- lsp enhanced
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	{ "ray-x/lsp_signature.nvim", after = "nvim-lspconfig" },
	-- Visualize lsp progress
	{
		"folke/noice.nvim",
		tag = "v4.9.0",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	-- Avante.nvim with build process
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
		opts = {
			-- add any opts here
			-- for example
			provider = "openai",
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
				timeout = 30000, -- timeout in milliseconds
				temperature = 0, -- adjust if needed
				max_tokens = 4096,
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			-- "echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			-- "ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	-- Autocompletion framework
	{ "hrsh7th/vim-vsnip" },
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.3.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "onsails/lspkind.nvim" },
			{ "lukas-reineke/cmp-under-comparator" },
			{ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
			{ "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp" },
			{ "andersevenrud/cmp-tmux", after = "cmp-nvim-lua" },
			{ "hrsh7th/cmp-path", after = "cmp-tmux" },
			{ "f3fora/cmp-spell", after = "cmp-path" },
			{ "hrsh7th/cmp-buffer", after = "cmp-spell" },
			{ "kdheepak/cmp-latex-symbols", after = "cmp-buffer" },
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		},
	},
	{ "mrcjkb/rustaceanvim", tag = "v5.18.0" },
	{ "scalameta/nvim-metals", dependencies = { "nvim-lua/plenary.nvim" } },
	-- trouble
	{ "folke/trouble.nvim", dependencies = "kyazdani42/nvim-web-devicons" },
	-- grammar highlight
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
	-- theme
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- comment
	{ "numToStr/Comment.nvim" },
	-- code formatting
	{ "nvimtools/none-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },
	-- status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
	},
	-- bufferline
	{ "akinsho/bufferline.nvim", tag = "v4.9.1", dependencies = "nvim-tree/nvim-web-devicons" },
	-- Leap
	{
		"ggandor/flit.nvim",
		dependencies = "ggandor/leap.nvim",
	},
	-- vista
	{ "liuchengxu/vista.vim" },
	-- mini.nvim
	{ "echasnovski/mini.cursorword" },
	{ "echasnovski/mini.pairs" },
	{ "echasnovski/mini.ai", branch = "stable" },
	{ "echasnovski/mini.icons", branch = "stable" },
	{ "echasnovski/mini.surround", branch = "stable" },
	{ "echasnovski/mini.files", branch = "stable" },
	-- colorizer
	{ "norcalli/nvim-colorizer.lua" },
	-- repeat
	{ "tpope/vim-repeat" },
	-- startup
	{ "dstein64/vim-startuptime" },
	-- which key, hint the next shortcut key
	{ "folke/which-key.nvim" },
	-- marks
	{ "chentoast/marks.nvim" },
	-- git
	{ "lewis6991/gitsigns.nvim", tag = "release" },
	-- terminal
	{ "akinsho/toggleterm.nvim", tag = "v2.2.1" },
	-- zen
	{ "folke/zen-mode.nvim" },
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"cljoly/telescope-repo.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"ThePrimeagen/harpoon",
			"AckslD/nvim-neoclip.lua",
		},
	},
}
