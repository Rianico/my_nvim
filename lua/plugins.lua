local packer = require("packer")
packer.init({ git = { default_url_format = "git@github.com:%s" } })
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
	use("j-hui/fidget.nvim")
	-- Autocompletion framework
	-- See hrsh7th other plugins for more great completion sources!
	-- Snippet engine
	use("hrsh7th/vim-vsnip")
	use({ "L3MON4D3/LuaSnip", requires = { "rafamadriz/friendly-snippets" } })
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
			{ "hrsh7th/cmp-vsnip", after = "vim-vsnip" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		},
	})
	-- Adds extra functionality over rust analyzer
	use({
		"simrat39/rust-tools.nvim",
		requires = { { "nvim-lua/plenary.nvim", opt = false }, { "mfussenegger/nvim-dap", opt = true } },
	})
	--
	-- trouble
	use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })
	--
	-- grammar highlight
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })
	--
	-- file exploer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		run = ":TSUpdate",
	})
	-- about pair
	use("tpope/vim-surround")
	-- theme
	use("sainnhe/gruvbox-material")
	-- comment
	use("numToStr/Comment.nvim")
	-- code formatting
	use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	-- bufferline
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })
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
		tag = "0.1.1",
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
