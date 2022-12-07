local packer = require("packer")
packer.init({ git = { default_url_format = "git@github.com:%s" } })
packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- lsp
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	-- Visualize lsp progress
	use("j-hui/fidget.nvim")
	-- Autocompletion framework
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
	-- See hrsh7th other plugins for more great completion sources!
	-- Snippet engine
	use("hrsh7th/vim-vsnip")
	use({ "L3MON4D3/LuaSnip", requires = { "rafamadriz/friendly-snippets" } })
	-- Adds extra functionality over rust analyzer
	use({
		"simrat39/rust-tools.nvim",
		requires = { { "nvim-lua/plenary.nvim", opt = false }, { "mfussenegger/nvim-dap", opt = true } },
	})
	-- UI enhanced
	local lspsaga_config = require("lsp.lspsaga")
	use({ "glepnir/lspsaga.nvim", branch = "main", config = lspsaga_config.lspsaga() })
	use({ "ray-x/lsp_signature.nvim", after = "nvim-lspconfig" })

	-- trouble
	use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })

	-- grammer highlight
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("p00f/nvim-ts-rainbow")

	-- file exploer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		run = ":TSUpdate",
	})
	-- about pair
	use("tpope/vim-surround")
	-- theme
	use("junegunn/seoul256.vim")
	use("sainnhe/gruvbox-material")
	-- fzf
	use("junegunn/fzf")
	use("junegunn/fzf.vim")
	-- comment
	use("numToStr/Comment.nvim")
	-- code formatting
	use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	-- hop
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
	})
	-- vista
	use("liuchengxu/vista.vim")
	-- mini.nvim
	use("echasnovski/mini.cursorword")
	use("echasnovski/mini.pairs")
	use({ "echasnovski/mini.ai", branch = "stable" })
end)
