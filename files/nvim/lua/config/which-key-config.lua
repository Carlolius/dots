-- Which-key config
-------------------

local wk = require("which-key")
vim.o.timeoutlen = 350

local leader = {
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Toogle NvimTree" },
	["b"] = {
		name = "+buffer",
		["b"] = { "<cmd>:e #<cr>", "Switch to other buffer" },
		["p"] = { "<cmd>:bprev<cr>", "Previous buffer" },
		["n"] = { "<cmd>:bnext<cr>", "Next buffer" },
		["d"] = { "<cmd>:bd<cr>", "Delete buffer" },
		["e"] = {
			function()
				vim.cmd [[
				let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
				if !empty(buffers)
					exe 'bd '.join(buffers, ' ')
				else
					echo 'No buffer deleted'
				endif
				]]
			end,
			"Delete empty buffers"},
	},

	["f"] = {
		name = "+floating",
		["l"] = { "<cmd>lua Lazygit_toggle()<cr>", "Lazygit" },
		["m"] = { "<cmd>:Glow<cr>", "Markdown Glow" },
	},
	["l"] = {
		name = "+LSP",
		["i"] = { "<cmd>:LspStart<cr>", "LSP start" },
		["s"] = { "<cmd>:LspStop<cr>", "LSP stop" },
		["f"] = { "<cmd>:LspInfo<cr>", "LSP info" },
	},
	["h"] = {
		name = "+help",
		t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
		c = { "<cmd>:Telescope commands<cr>", "Commands" },
		h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
		m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
		k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
		s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
		f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
		o = { "<cmd>:Telescope vim_options<cr>", "Options" },
		a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
		p = {
			name = "+packer",
			["p"] = { "<cmd>PackerSync<cr>", "Sync" },
			["s"] = { "<cmd>PackerStatus<cr>", "Status" },
			["i"] = { "<cmd>PackerInstall<cr>", "Install" },
			["c"] = { "<cmd>PackerCompile<cr>", "Compile" },
			["l"] = { "<cmd>PackerClean<cr>", "Clean" },
		},
	},
	["s"] = {
		name = "+spell",
		["c"] = { "<cmd>:LanguageToolCheck<cr>", "Language Tool Check" },
		["C"] = { "<cmd>:LanguageToolClear<cr>", "Language Tool Clear" },
		["g"] = { "<cmd>:set spelllang=gl_ES<cr>", "Set Galician" },
		["s"] = { "<cmd>:set spelllang=es_ES<cr>", "Set Spanish" },
		["e"] = { "<cmd>:set spelllang=en<cr>", "Set English" },
	},
	["t"] = {
		name = "+telescope",
		["p"] = { "<cmd>lua require('telescope').extensions.neoclip.default()<cr>", "Clipboard" },
		["f"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find files" },
		["g"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live grep" },
		["b"] = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
		["h"] = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help tags" },
		["d"] = { "<cmd>Telescope lsp_document_diagnostics<cr>", "Document diagnostics" },
		["c"] = { "<cmd>Telescope colorscheme<cr>", "Colorschemes"},
		["m"] = { "<cmd>Telescope marks<cr>", "Marks"},
		["w"] = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace diagnostics" },
		["."] = { ":Telescope file_browser<CR>", "Browse Files" },
		[":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
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
