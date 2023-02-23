-- Plugins
----------

-- Ensure that packer is installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	Packer_bootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.startup({
	function(use)
		-- Packer can manage itself
		use({ "wbthomason/packer.nvim" })

		-- Easy comment
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

		-- Color f & t
		use({ "unblevable/quick-scope", event = "BufWinEnter" })

		-- Autocomplete
		-- Nvim-Cmp
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"L3MON4D3/LuaSnip",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-calc",
				"hrsh7th/cmp-emoji",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"rafamadriz/friendly-snippets",
				"saadparwaiz1/cmp_luasnip",
			},
			config = "require('config.cmp-config')",
		})

		-- Autopairing
		use({
			"windwp/nvim-autopairs",
			config = "require('config.autopairs')",
			after = "nvim-cmp",
		})

		-- CodeAction menu
		require("packer").use({
			"weilbith/nvim-code-action-menu",
			cmd = "CodeActionMenu",
		})

		-- ColorSchemes
		use({ "Pocco81/Catppuccino.nvim" }) -- Catppuccino
		use({ "folke/tokyonight.nvim" }) -- Tokyonight
		use({ "morhetz/gruvbox" }) -- Gruvbox
		use({ "olimorris/onedarkpro.nvim" }) -- One Dark Pro
		use({ "rebelot/kanagawa.nvim" }) -- Kanagawa
		use({ "wuelnerdotexe/vim-enfocado" }) -- Enfocado
		use({ "glepnir/zephyr-nvim" }) -- Zephyr

		-- File explorer
		use({
			"kyazdani42/nvim-tree.lua",
			requires = "kyazdani42/nvim-web-devicons",
			cmd = "NvimTreeToggle",
			config = "require('config.nvim-tree-config')",
		})

		-- GitHub Copilot
		-- use({ "github/copilot.vim" })
		use({
			"zbirenbaum/copilot.lua",
			event = "VimEnter",
			config = function()
				vim.schedule(function()
					require("config.copilot-config")
				end)
			end,
		})

		use({
			"zbirenbaum/copilot-cmp",
			after = { "copilot.lua", "nvim-cmp" },
			config = function()
				require("config.copilot_cmp-config")
			end,
		})

		-- Indent blankline
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = "require('config.indent-blankline')",
		})

		-- LanguageTool
		use({ "brymer-meneses/grammar-guard.nvim" })

		-- Markdown
		use({ "plasticboy/vim-markdown" }) -- Markdown highlighting
		use({
			"iamcco/markdown-preview.nvim", -- Preview Markdown file in browser
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
			ft = "markdown",
			cmd = { "MarkdownPreview" },
		})

		-- Mason
		use({
			"williamboman/mason.nvim",
			config = "require('config.mason-config')"
		})

		use({
			"williamboman/mason-lspconfig.nvim",
			require("mason").setup(),
			config = "require('config.mason_lspconfig-config')",
		})

		use({ "neovim/nvim-lspconfig" })

		-- Neoclip clipboard
		use({
			"AckslD/nvim-neoclip.lua",
			requires = {
				-- you'll need at least one of these
				{ "nvim-telescope/telescope.nvim" },
				-- {'ibhagwan/fzf-lua'},
			},
			config = function()
				require("neoclip").setup()
			end,
		})

		-- Null-ls
		use({ "jose-elias-alvarez/null-ls.nvim", requires = {
			"nvim-lua/plenary.nvim",
		} })

		-- Show colors in code RGB, HEX...
		use({
			"norcalli/nvim-colorizer.lua",
			config = "require('config.colorizer-config')",
			event = "BufRead",
		})

		-- Statusline
		use({
			"freddiehaddad/feline.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = "require('config.feline-statusline')",
		})
		-- Necessary for the git info
		use({
			"lewis6991/gitsigns.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
			},
			config = "require('config.gitsings-config')",
		})

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			cmd = "Telescope",
			config = "require('config.telescope-config')",
		})

		-- Terminal
		use({ "akinsho/nvim-toggleterm.lua", config = "require('config.toggleterm-config')" })

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			-- event = "BufRead",
			run = ":TSUpdate",
			event = "BufWinEnter",
			config = "require('config.treesitter-config')",
		})

		-- Which key
		use({
			"folke/which-key.nvim",
			event = "BufWinEnter",
			config = "require('config.which-key-config')",
		})

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if Packer_bootstrap then
			require("packer").sync()
		end
	end,
})
