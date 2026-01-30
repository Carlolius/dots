-- Plugin management using lazy.nvim
-- Bootstrap lazy.nvim if needed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
	"git",
	"clone",
	"--filter=blob:none",
	"https://github.com/folke/lazy.nvim.git",
	"--branch=stable", -- latest stable
	lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Utility
  { "numToStr/Comment.nvim", config = function() require('Comment').setup() end },
  { "unblevable/quick-scope", event = "BufWinEnter" },

  -- Completion
  {
	"hrsh7th/nvim-cmp",
	dependencies = {
	  "L3MON4D3/LuaSnip",
	  "hrsh7th/cmp-buffer",
	  "hrsh7th/cmp-calc",
	  "hrsh7th/cmp-emoji",
	  "hrsh7th/cmp-nvim-lua",
	  "hrsh7th/cmp-path",
	  "hrsh7th/cmp-cmdline",
	  "rafamadriz/friendly-snippets",
	  "saadparwaiz1/cmp_luasnip",
	},
	config = function() require('config.cmp-config') end,
  },

  -- Autopairs
  { "windwp/nvim-autopairs", event = "InsertEnter", config = function() require('config.autopairs') end },

  -- Code action menu
  { "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },

  -- Colorschemes
  { "Pocco81/Catppuccino.nvim" },
  { "folke/tokyonight.nvim" },
  { "morhetz/gruvbox" },
  { "olimorris/onedarkpro.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "wuelnerdotexe/vim-enfocado" },
  { "glepnir/zephyr-nvim" },

  -- File explorer (updated)
  {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "kyazdani42/nvim-web-devicons" },
	cmd = "NvimTreeToggle",
	config = function() require('config.nvim-tree-config') end,
  },

  -- Indent guide
  { "lukas-reineke/indent-blankline.nvim", config = function() require('config.indent-blankline') end },

  -- Grammar/LangTool
  { "brymer-meneses/grammar-guard.nvim" },

  -- Markdown
  { "plasticboy/vim-markdown" },
  { "iamcco/markdown-preview.nvim", ft = "markdown", cmd = "MarkdownPreview", build = function() vim.fn['mkdp#util#install']() end },

  -- Clipboard manager
  { "AckslD/nvim-neoclip.lua", dependencies = { "nvim-telescope/telescope.nvim" }, config = function() require('neoclip').setup() end },

  -- Colorizer
  { "norcalli/nvim-colorizer.lua", event = "BufRead", config = function() require('config.colorizer-config') end },

  -- Statusline
  { "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons" }, config = function() require('config.lualine-config') end },

  -- Git signs
  { "lewis6991/gitsigns.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function() require('config.gitsings-config') end },

  -- Telescope
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, cmd = "Telescope", config = function() require('config.telescope-config') end },

  -- Terminal
  { "akinsho/nvim-toggleterm.lua", config = function() require('config.toggleterm-config') end },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = "BufWinEnter", config = function() require('config.treesitter-config') end },

  -- WhichKey
  { "folke/which-key.nvim", event = "BufWinEnter", config = function() require('config.which-key-config') end },

}, {
  install = { colorscheme = { "onedark_dark", "tokyonight" } },
})
