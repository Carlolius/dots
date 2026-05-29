-- Which-key config
-------------------

local wk = require("which-key")
vim.o.timeoutlen = 350

local setup = {
	notify = true,
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
		colors = true,
	},
	keys = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	win = {
		-- don't allow the popup to overlap with the cursor
		no_overlap = true,
		-- width = 1,
		-- height = { min = 4, max = 25 },
		-- col = 0,
		-- row = math.huge,
		-- border = "none",
		padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
		title = true,
		title_pos = "center",
		zindex = 1000,
		-- Additional vim.wo and vim.bo options
		bo = {},
		wo = {
			-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
		},
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = {
		{ "<auto>", mode = "nxsot" },
	},
	disable = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

wk.add({
    { "<leader>b", group = "buffer" },
    { "<leader>bb", "<cmd>:e #<cr>", desc = "Switch to other buffer" },
    { "<leader>bd", "<cmd>:bd<cr>", desc = "Delete buffer" },
    { "<leader>be", function()
	    vim.cmd [[
	    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
	    if !empty(buffers)
		    exe 'bd '.join(buffers, ' ')
	    else
		    echo 'No buffer deleted'
		    endif
		    ]]
    end,
    desc = "Delete empty buffers" },
    { "<leader>bn", "<cmd>:bnext<cr>", desc = "Next buffer" },
    { "<leader>bp", "<cmd>:bprev<cr>", desc = "Previous buffer" },
    { "<leader>bt", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toogle NvimTree" },
    { "<leader>f", group = "floating" },
    { "<leader>fh", "<cmd>lua Horizontal_toggle()<cr>", desc = "Horizontal" },
    { "<leader>fl", "<cmd>lua Lazygit_toggle()<cr>", desc = "Lazygit" },
    { "<leader>ft", "<cmd>:ToggleTerm<cr>", desc = "Toggle terminal" },
    { "<leader>fv", "<cmd>lua Vertical_toggle()<cr>", desc = "Vertical" },
    { "<leader>g", group = "Git" },
    { "<leader>gb", "<cmd>:Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
    { "<leader>gl", "<cmd>:Gitsigns toggle_linehl<cr>", desc = "Toggle linehl" },
    { "<leader>gn", "<cmd>:Gitsigns toggle_numhl<cr>", desc = "Toggle numhl" },
    { "<leader>gs", "<cmd>:Gitsigns toggle_signs<cr>", desc = "Toggle signs" },
    { "<leader>gw", "<cmd>:Gitsigns toggle_word_diff<cr>", desc = "Toggle word diff" },
    { "<leader>h", group = "help" },
    { "<leader>ha", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>hb", "<cmd>Telescope builtin<cr>", desc = "Builtin" },
    { "<leader>hc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>hf", "<cmd>Telescope filetypes<cr>", desc = "File Types" },
    { "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>hm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>ho", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>hp", group = "plugins" },
    { "<leader>hpi", "<cmd>Lazy install<cr>", desc = "Install" },
    { "<leader>hpl", "<cmd>Lazy clean<cr>", desc = "Clean" },
    { "<leader>hpp", "<cmd>Lazy sync<cr>", desc = "Sync" },
    { "<leader>hps", "<cmd>Lazy<cr>", desc = "Status" },
    { "<leader>hpu", "<cmd>Lazy update<cr>", desc = "Update Plugins" },
    { "<leader>hs", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>s", group = "spell" },
    { "<leader>se", "<cmd>:set spelllang=en<cr>", desc = "Set English" },
    { "<leader>sg", "<cmd>:set spelllang=gl_ES<cr>", desc = "Set Galician" },
    { "<leader>ss", "<cmd>:set spelllang=es_ES<cr>", desc = "Set Spanish" },
    { "<leader>t", group = "telescope" },
    { "<leader>t:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>tc", "<cmd>Telescope colorscheme<cr>", desc = "Colorschemes" },
    { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>tg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>tm", "<cmd>Telescope marks<cr>", desc = "Marks" },
    { "<leader>tp", "<cmd>Telescope neoclip default<cr>", desc = "Clipboard" },
    { "<leader>tt", "<cmd>Telescope treesitter<cr>", desc = "Treesitter" },
    { "<leader>w", group = "windows" },
    { "<leader>w-", "<C-W>s", desc = "split-window-below" },
    { "<leader>w2", "<C-W>v", desc = "layout-double-columns" },
    { "<leader>w=", "<C-W>=", desc = "balance-window" },
    { "<leader>wH", "<C-W>5<", desc = "expand-window-left" },
    { "<leader>wJ", "<cmd>resize +5<cr>", desc = "expand-window-below" },
    { "<leader>wK", "<cmd>resize -5<cr>", desc = "expand-window-up" },
    { "<leader>wL", "<C-W>5>", desc = "expand-window-right" },
    { "<leader>wd", "<C-W>c", desc = "delete-window" },
    { "<leader>wh", "<C-W>h", desc = "window-left" },
    { "<leader>wj", "<C-W>j", desc = "window-below" },
    { "<leader>wk", "<C-W>k", desc = "window-up" },
    { "<leader>wl", "<C-W>l", desc = "window-right" },
    { "<leader>ws", "<C-W>s", desc = "split-window-below" },
    { "<leader>wv", "<C-W>v", desc = "split-window-below" },
    { "<leader>ww", "<C-W>w", desc = "other-window" },
    { "<leader>w|", "<C-W>v", desc = "split-window-right" },
  })

wk.setup(setup)
