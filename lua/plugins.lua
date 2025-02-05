local packer = require("packer")
packer.startup(function(use)
	-- speedup nvim
	use("lewis6991/impatient.nvim")
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- lsp
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	-- dap
	use({
		"mfussenegger/nvim-dap",
		tag = "0.8.0",
		requires = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"williamboman/mason.nvim",
		},
	})
	-- lsp enhanced
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})
	use({ "ray-x/lsp_signature.nvim", after = "nvim-lspconfig" })
	-- Visualize lsp progress
	-- use({ "j-hui/fidget.nvim", tag = "v1.4.5" })
	use({
		"folke/noice.nvim",
		tag = "v4.9.0",
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	})

	-- Autocompletion framework
	-- See hrsh7th other plugins for more great completion sources!
	-- Snippet engine
	use("hrsh7th/vim-vsnip")
	use({ "L3MON4D3/LuaSnip", tag = "v2.*", requires = { "rafamadriz/friendly-snippets" } })
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			-- LSP 美化
			{ "onsails/lspkind.nvim" },
			-- sort completion
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
	})
	use({ "mrcjkb/rustaceanvim", tag = "v5.18.0" })
	use({ "scalameta/nvim-metals", requires = { "nvim-lua/plenary.nvim" } })
	-- trouble
	use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })
	-- about pair
	-- use("tpope/vim-surround")
	-- grammar highlight
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })
	--
	-- file exploer
	use({
		"nvim-tree/nvim-tree.lua",
		"nvim-tree/nvim-web-devicons",
		run = ":TSUpdate",
	})
	-- theme
	-- use("sainnhe/gruvbox-material")
	-- use({ 'rose-pine/neovim', as = 'rose-pine' })
	use({ "catppuccin/nvim", as = "catppuccin" })
	-- comment
	use("numToStr/Comment.nvim")
	-- code formatting
	use({ "nvimtools/none-ls.nvim", requires = "nvim-lua/plenary.nvim" })
	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	-- bufferline
	use({ "akinsho/bufferline.nvim", tag = "v4.8.*", requires = "nvim-tree/nvim-web-devicons" })
	-- Leap
	use({
		"ggandor/flit.nvim",
		requires = "ggandor/leap.nvim",
	})
	-- vista
	use("liuchengxu/vista.vim")
	-- mini.nvim
	use("echasnovski/mini.cursorword")
	use("echasnovski/mini.pairs")
	use({ "echasnovski/mini.ai", branch = "stable" })
	use({ "echasnovski/mini.icons", branch = "stable" })
	use({ "echasnovski/mini.surround", branch = "stable" })
	use({ "echasnovski/mini.files", branch = "stable" })

	use({ "norcalli/nvim-colorizer.lua" })
	-- repeat
	use("tpope/vim-repeat")
	-- startup
	use("dstein64/vim-startuptime")
	-- which key, hint the next shortcut key
	use("folke/which-key.nvim")
	-- marks
	use("chentoast/marks.nvim")
	-- git
	use({ "lewis6991/gitsigns.nvim", tag = "release" })
	-- terminal
	use({ "akinsho/toggleterm.nvim", tag = "v2.2.1" })
	-- zen
	use("folke/zen-mode.nvim")
	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			-- "nvim-telescope/telescope-project.nvim",
			"cljoly/telescope-repo.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"ThePrimeagen/harpoon",
			"AckslD/nvim-neoclip.lua",
		},
	})
end)
