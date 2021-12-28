-- Plugins
----------
-- Ensure that packer is installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return require('packer').startup{
	function(use)
		-- Packer can manage itself
		use {"wbthomason/packer.nvim"}

		use {"b3nj5m1n/kommentary"} -- Easy comment

		-- Color f & t
		use {
			"unblevable/quick-scope",
			event = "BufWinEnter"
		}

		-- Autocomplete
		  -- Nvim-Cmp
		use {
			"hrsh7th/nvim-cmp",
			requires = {
				"L3MON4D3/LuaSnip",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-calc",
				"hrsh7th/cmp-emoji",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-path",
				"rafamadriz/friendly-snippets",
				"saadparwaiz1/cmp_luasnip",
			},
			config = "require('config.cmp-config')"
		}

		-- Autopairing
		use {
			"windwp/nvim-autopairs",
			config = "require('config.autopairs')",
			after = "nvim-cmp"
		}

		-- CodeAction menu
		require('packer').use({
			'weilbith/nvim-code-action-menu',
			cmd = 'CodeActionMenu',
		})

		-- ColorSchemes
		use {"morhetz/gruvbox"} -- Gruvbox
		use {"folke/tokyonight.nvim"} -- Tokyonight
		use {"Pocco81/Catppuccino.nvim"} -- Catppuccino
		use {"wuelnerdotexe/vim-enfocado"} -- Enfocado
		use {"rebelot/kanagawa.nvim"} -- Kanagawa

		 -- File explorer
		 use {
			 'kyazdani42/nvim-tree.lua',
			 requires = 'kyazdani42/nvim-web-devicons',
			 cmd = "NvimTreeToggle",
			 config = "require('config.nvim-tree-config')"
		 }

		-- Gkeep, Google Keep in Nvim
		use {"stevearc/gkeep.nvim", run = "UpdateRemotePlugins"}

		-- LanguageTool
		use {
			"dpelle/vim-LanguageTool",
			config = "require('config.languagetool')",
			cmd = "LanguageToolCheck",
			requires = {"matze-dd/YaLafi"},
		}

		-- Markdown
		use {"npxbr/glow.nvim", run = "GlowInstall"} -- Markdown visualizer
		use {"plasticboy/vim-markdown"} -- Markdown highlighting

		-- Neoclip clipboard
		use {
			"AckslD/nvim-neoclip.lua",
			config = "require('neoclip')"
		}

		-- Nvim LSP plugin
		use {
			"neovim/nvim-lspconfig",
			event = "BufRead",
			config = "require('config.lsp.lsp')"
		}
		use {"williamboman/nvim-lsp-installer"}

		-- Show colors in code RGB, HEX...
		use {
			"norcalli/nvim-colorizer.lua",
			config = "require('config.colorizer-config')",
			event = "BufRead"
		}

		-- Statusline
		use {
			"famiu/feline.nvim",
			requires = {"kyazdani42/nvim-web-devicons"},
			config = "require('config.feline-statusline')",
		}
			-- Necessary for the git info
		use {
			"lewis6991/gitsigns.nvim",
			requires = {
				"nvim-lua/plenary.nvim"
			},
			config = "require('config.gitsings-config')"
		}

		-- Telescope
		use {
			"nvim-telescope/telescope.nvim",
			requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
			cmd = "Telescope",
			config = "require('config.telescope-config')"
		}

		-- Terminal
		use {
			"akinsho/nvim-toggleterm.lua",
			config = "require('config.toggleterm-config')"
		}

		-- Treesitter
		use {
			"nvim-treesitter/nvim-treesitter",
			-- event = "BufRead",
			run = ":TSUpdate",
			event = "BufWinEnter",
			config = "require('config.treesitter-config')"
		}

		-- Which key
		use {
			"folke/which-key.nvim",
			event = "BufWinEnter",
			config = "require('config.which-key-config')"
		}

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require('packer').sync()
		end
	end
}
