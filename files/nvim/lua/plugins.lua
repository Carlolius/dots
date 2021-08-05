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
		use {'wbthomason/packer.nvim'} -- Packer can manage itself
		use {'morhetz/gruvbox'} -- Gruvbox colorscheme
		use {'folke/tokyonight.nvim'}
		use {'nvim-treesitter/nvim-treesitter'}
		use {'b3nj5m1n/kommentary'} -- Easy comment
		use {'rafamadriz/friendly-snippets'} -- Snippets
		use {'npxbr/glow.nvim', run = "GlowInstall"} -- Markdown visualizer
		use {'gabrielelana/vim-markdown'} -- Markdown highlighting
		use {'kyazdani42/nvim-tree.lua'} -- File explorer

		-- LanguageTool
		use {
			'dpelle/vim-LanguageTool',
			config = function ()
				require("config.languagetool")
			end,
			requires = {'matze-dd/YaLafi'},
		}

		-- Terminal
		use {
			'akinsho/nvim-toggleterm.lua',
			config = function()
				require("config.toggle")
			end
		}

		-- Nvim LSP plugin
		use {
			'neovim/nvim-lspconfig',
			config = function()
				require("config.lsp")
			end
		}

		-- Autocomplete
		use {
			'hrsh7th/nvim-compe',
			event = "InsertEnter",
			config = function()
				require("config.compe-config")
			end
		}

		-- Autopairing
		use {
			'windwp/nvim-autopairs',
			config = function()
				require("config.autopairs")
			end
		}

		-- Telescope
		use {
			'nvim-telescope/telescope.nvim',
			requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
		}

		-- Which key
		use {
			'folke/which-key.nvim',
			config = function()
				require("which-key").setup {
					require("config.which-key-config")
				}
			end
		}

		-- Statusline
		use {
			'glepnir/galaxyline.nvim',
			branch = 'main',
			-- your statusline
			config = function()
				require'config.my-statusline' end,
				-- some optional icons
				requires = {'kyazdani42/nvim-web-devicons', opt = true}
		}
	end
}
