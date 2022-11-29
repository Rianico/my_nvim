return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- lsp
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	-- Autocompletion framework
	use("hrsh7th/nvim-cmp")
	use({
		-- cmp LSP completion
		"hrsh7th/cmp-nvim-lsp",
		-- cmp Snippet completion
		"hrsh7th/cmp-vsnip",
		-- cmp Path completion
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		after = { "hrsh7th/nvim-cmp" },
		requires = { "hrsh7th/nvim-cmp" },
	})
	-- See hrsh7th other plugins for more great completion sources!
	-- Snippet engine
	use("hrsh7th/vim-vsnip")
	-- lsp美化
	use("onsails/lspkind-nvim")
	-- Adds extra functionality over rust analyzer
	use("simrat39/rust-tools.nvim")

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
	use("tpope/vim-unimpaired")
	-- theme
	use("junegunn/seoul256.vim")
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
end)
