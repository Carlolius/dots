-- Plugins
----------
-- ensure that packer is installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    vim.api.nvim_command'packadd packer.nvim'
end

return require('packer').startup(function()
	use {'wbthomason/packer.nvim'} -- Packer can manage itself
	use {'morhetz/gruvbox'} -- Gruvbox colorscheme
	use {'nvim-treesitter/nvim-treesitter'}
	use {'neovim/nvim-lspconfig'} -- Nvim LSP plugin
	use {'hrsh7th/nvim-compe'} -- Autocomplete
	use {'b3nj5m1n/kommentary'} -- Easy comment
	use {'kabouzeid/nvim-lspinstall'} -- Auto install LSP servers
	use {'rafamadriz/friendly-snippets'} -- Snippets
	use {'akinsho/nvim-toggleterm.lua'} -- Terminal
	use {'folke/which-key.nvim', -- Help for keybindigns
		config = function()
			require("which-key").setup {
				-- your configuration comes here
			}end
	}

	use {'glepnir/galaxyline.nvim', -- Statusline
		branch = 'main',
		-- your statusline
		config = function() require'plugins.my-statusline' end,
		-- some optional icons
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}

	use {'kyazdani42/nvim-tree.lua'} -- File explorer

	use {'nvim-telescope/telescope.nvim',
	requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
}
end)
