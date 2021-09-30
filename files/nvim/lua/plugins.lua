-- Plugins
----------
-- ensure that packer is installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
	vim.api.nvim_command'packadd packer.nvim'
end

return require('packer').startup{
	function(use)
		-- Packer can manage itself
		use {"wbthomason/packer.nvim"}

		use {"b3nj5m1n/kommentary"} -- Easy comment
		use {"unblevable/quick-scope"} -- Color f & t

		 -- File explorer
		 use {
			 'kyazdani42/nvim-tree.lua',
			 requires = 'kyazdani42/nvim-web-devicons',
			 config = function() require'nvim-tree'.setup {} end
		 }
		-- Markdown
		use {"npxbr/glow.nvim", run = "GlowInstall"} -- Markdown visualizer
		use {"plasticboy/vim-markdown"} -- Markdown highlighting

		-- Treesitter
		use {
			"nvim-treesitter/nvim-treesitter",
			-- event = "BufRead",
			run = ":TSUpdate",
			config = function()
				require("config.treesitter-config")
			end,
		}

		-- ColorSchemes
		use {"morhetz/gruvbox"} -- Gruvbox
		use {"folke/tokyonight.nvim"} -- Tokyonight
		use {"Pocco81/Catppuccino.nvim"} -- Catppuccino
		use {"wuelnerdotexe/vim-enfocado"} -- Enfocado

		-- Show colors in code RGB, HEX...
		use {
			"norcalli/nvim-colorizer.lua",
			config = function ()
				require"colorizer".setup()
			end
		}

		-- Neoclip clipboard
		use {
			"AckslD/nvim-neoclip.lua",
			config = function()
				require("neoclip").setup()
			end,
		}

		-- LanguageTool
		use {
			"dpelle/vim-LanguageTool",
			config = function ()
				require("config.languagetool")
			end,
			requires = {"matze-dd/YaLafi"},
		}

		-- Terminal
		use {
			"akinsho/nvim-toggleterm.lua",
			config = function()
				require("config.toggleterm-config")
			end
		}

		-- Nvim LSP plugin
		use {
			"neovim/nvim-lspconfig",
			config = function()
				require("config.lsp")
			end
		}

		-- Autocomplete
		  -- Nvim-Cmp
		use {
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-nvim-lsp",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"rafamadriz/friendly-snippets",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-calc",
				"hrsh7th/cmp-emoji"
			},
			config = function()
				require("config.cmp-config")
			end,
		}

		  -- Tabnine
		use {
			"tzachar/cmp-tabnine",
			run = "./install.sh",
			requires = "hrsh7th/nvim-cmp"
		}

		-- Autopairing
		use {
			"windwp/nvim-autopairs",
			config = function()
				require("config.autopairs")
			end
		}

		-- Telescope
		use {
			"nvim-telescope/telescope.nvim",
			requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
		}

		-- Which key
		use {
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup {
					require("config.which-key-config")
			}
			end
		}

		-- Statusline
		use {
			"famiu/feline.nvim",
			config = function()
				require("config.feline-statusline") end,
				requires = {{"kyazdani42/nvim-web-devicons"},
			},
		}
		-- Necessary for the git info
		use {
			"lewis6991/gitsigns.nvim",
			requires = {
				"nvim-lua/plenary.nvim"
			},
			config = function()
				require("config.gitsings-config")
			end
		}
		--[[ use {
			"glepnir/galaxyline.nvim",
			branch = "main",
			-- your statusline
			config = function()
				require"config.my-statusline" end,
				-- some optional icons
				requires = {"kyazdani42/nvim-web-devicons", opt = true}
		} ]]
	end
}
