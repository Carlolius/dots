-- Which-key config
-------------------

local wk = require("which-key")
vim.o.timeoutlen = 350

local leader = {
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Toogle NvimTree" },
	["b"] = {
		name = "+buffer",
		["b"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
		["p"] = { "<cmd>:bprev<cr>", "Previous Buffer" },
		["n"] = { "<cmd>:bnext<cr>", "Next Buffer" },
		["d"] = { "<cmd>:bd<cr>", "Delete Buffer" },
	},
	["f"] = {
		name = "+floating",
		["l"] = { "<cmd>lua Lazygit_toggle()<cr>", "Lazygit" },
	},
	["p"] = {
		name = "+packer",
		["p"] = { "<cmd>PackerSync<cr>", "Sync" },
		["s"] = { "<cmd>PackerStatus<cr>", "Status" },
		["i"] = { "<cmd>PackerInstall<cr>", "Install" },
		["c"] = { "<cmd>PackerCompile<cr>", "Compile" },
		["l"] = { "<cmd>PackerClean<cr>", "Clean" },
	},
	["t"] = {
		name = "+telescope",
		["f"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find files" },
		["g"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live grep" },
		["b"] = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
		["h"] = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help tags" },
	},
	["w"] = {
		name = "+windows",
		["w"] = { "<C-W>w", "other-window" },
		["d"] = { "<C-W>c", "delete-window" },
		["-"] = { "<C-W>s", "split-window-below" },
		["|"] = { "<C-W>v", "split-window-right" },
		["2"] = { "<C-W>v", "layout-double-columns" },
		["h"] = { "<C-W>h", "window-left" },
		["j"] = { "<C-W>j", "window-below" },
		["l"] = { "<C-W>l", "window-right" },
		["k"] = { "<C-W>k", "window-up" },
		["H"] = { "<C-W>5<" , "expand-window-left" },
		["J"] = { "resize +5", "expand-window-below" },
		["L"] = { "<C-W>5>" , "expand-window-right" },
		["K"] = { "resize -5", "expand-window-up" },
		["="] = { "<C-W>=", "balance-window" },
		["s"] = { "<C-W>s", "split-window-below" },
		["v"] = { "<C-W>v", "split-window-below" },
		["?"] = { "Windows", "fzf-window" },
	},
}

wk.register(leader, { prefix = "<leader>" })
