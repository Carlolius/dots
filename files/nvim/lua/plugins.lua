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
		use {'b3nj5m1n/kommentary'} -- Easy comment
		use {'npxbr/glow.nvim', run = "GlowInstall"} -- Markdown visualizer
		use {'gabrielelana/vim-markdown'} -- Markdown highlighting
		use {'unblevable/quick-scope'} -- Color f & t
		use {'kyazdani42/nvim-tree.lua'} -- File explorer

		-- Treesitter
		use {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"}

		-- ColorSchemes
		use {'morhetz/gruvbox'} -- Gruvbox
		use {'folke/tokyonight.nvim'} -- Tokyonight
		use {'Pocco81/Catppuccino.nvim'} -- Catppuccino

		-- Colors in code
		use {
			'norcalli/nvim-colorizer.lua',
			config = function ()
				require'colorizer'.setup()
			end
		}

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
		  -- Snippets
		use {'rafamadriz/friendly-snippets'} -- Snippets
		use({
            "L3MON4D3/LuaSnip",
            as = "luasnip",
            module = "luasnip",
            event = "InsertCharPre",
            config = function()
				require("config.snippets-config")
            end,
            requires = {
                "kitagry/vs-snippets",
                "rafamadriz/friendly-snippets",
                "kkonghao/snippet-dog",
            },
        })

		  -- Nvim-Cmp
        use({ "hrsh7th/cmp-nvim-lsp", as = "cmp-lsp", module = "cmp_nvim_lsp" })
        use({
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            module = "cmp",
            config = function()
				require("config.cmp-config")
            end,
            requires = {
                "cmp-lsp",
                "hrsh7th/cmp-path",
                { "saadparwaiz1/cmp_luasnip", requires = "luasnip" },
            },
        })

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
			'famiu/feline.nvim',
			config = function()
				require('config.feline-statusline') end,
				requires = {{'kyazdani42/nvim-web-devicons'},
				{'lewis6991/gitsigns.nvim'},
				requires = {
					'nvim-lua/plenary.nvim'
				},
				config = function ()
					require('config.gitsigns').setup()
				end,
			},
		}
		--[[ use {
			'glepnir/galaxyline.nvim',
			branch = 'main',
			-- your statusline
			config = function()
				require'config.my-statusline' end,
				-- some optional icons
				requires = {'kyazdani42/nvim-web-devicons', opt = true}
		} ]]
	end
}
