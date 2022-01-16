-- Which-key config
-------------------

local wk = require("which-key")
vim.o.timeoutlen = 350

local setup = {
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
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local mappings = {
	["b"] = {
		name = "+buffer",
		["b"] = { "<cmd>:e #<cr>", "Switch to other buffer" },
		["t"] = { "<cmd>Telescope buffers<cr>", "Buffers" },
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
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Toogle NvimTree" },
	["f"] = {
		name = "+floating",
		["l"] = { "<cmd>lua Lazygit_toggle()<cr>", "Lazygit" },
		["h"] = { "<cmd>lua Horizontal_toggle()<cr>", "Horizontal" },
		["v"] = { "<cmd>lua Vertical_toggle()<cr>", "Vertical" },
		["m"] = { "<cmd>:Glow<cr>", "Markdown Glow" },
		["t"] = { "<cmd>:ToggleTerm<cr>", "Toggle terminal" },
	},
	["g"] = {
		name = "+Git",
		["s"] = { "<cmd>:Gitsigns toggle_signs<cr>", "Toggle signs" },
		["n"] = { "<cmd>:Gitsigns toggle_numhl<cr>", "Toggle numhl" },
		["l"] = { "<cmd>:Gitsigns toggle_linehl<cr>", "Toggle linehl" },
		["w"] = { "<cmd>:Gitsigns toggle_word_diff<cr>", "Toggle word diff" },
		["b"] = { "<cmd>:Gitsigns toggle_current_line_blame<cr>", "Toggle line blame" },
	},
	["h"] = {
		name = "+help",
		["b"] = { "<cmd>Telescope builtin<cr>", "Builtin" },
		["c"] = { "<cmd>Telescope commands<cr>", "Commands" },
		["h"] = { "<cmd>Telescope help_tags<cr>", "Help Pages" },
		["m"] = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		["k"] = { "<cmd>Telescope keymaps<cr>", "Key Maps" },
		["s"] = { "<cmd>Telescope highlights<cr>", "Search Highlight Groups" },
		["f"] = { "<cmd>Telescope filetypes<cr>", "File Types" },
		["o"] = { "<cmd>Telescope vim_options<cr>", "Options" },
		["a"] = { "<cmd>Telescope autocommands<cr>", "Auto Commands" },
		p = {
			name = "+packer",
			["p"] = { "<cmd>PackerSync<cr>", "Sync" },
			["s"] = { "<cmd>PackerStatus<cr>", "Status" },
			["i"] = { "<cmd>PackerInstall<cr>", "Install" },
			["c"] = { "<cmd>PackerCompile<cr>", "Compile" },
			["l"] = { "<cmd>PackerClean<cr>", "Clean" },
			["u"] = {":PackerUpdate<cr>", "Update Plugins"},
		},
	},
	["l"] = {
		name = "+LSP",
		["i"] = { "<cmd>:LspStart<cr>", "LSP start" },
		["s"] = { "<cmd>:LspStop<cr>", "LSP stop" },
		["I"] = { "<cmd>:LspInfo<cr>", "LSP info" },
		["f"] = { "<cmd>lua vim.lsp.buf.formatting_sync()<cr>", "Format" },
		["k"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help"},
		["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover"},
		["R"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename"},
		["t"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition"},
		["D"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
		["d"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
		["c"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
		["r"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
		["l"] = { "<cmd>lua vim.lsp.buf.set_loclist()<CR>", "Set loclist" },
		["e"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show line diagnostics"},
		["n"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic"},
		["N"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic"}

	},
	["s"] = {
		name = "+spell",
		["g"] = { "<cmd>:set spelllang=gl_ES<cr>", "Set Galician" },
		["s"] = { "<cmd>:set spelllang=es_ES<cr>", "Set Spanish" },
		["e"] = { "<cmd>:set spelllang=en<cr>", "Set English" },
	},
	["t"] = {
		name = "+telescope",
		["p"] = { "<cmd>Telescope neoclip default<cr>", "Clipboard" },
		["t"] = { "<cmd>Telescope treesitter<cr>", "Treesitter" },
		["f"] = { "<cmd>Telescope find_files<cr>", "Find files" },
		["g"] = { "<cmd>Telescope live_grep<cr>", "Live grep" },
		["b"] = { "<cmd>Telescope buffers<cr>", "Buffers" },
		["h"] = { "<cmd>Telescope help_tags<cr>", "Help tags" },
		["c"] = { "<cmd>Telescope colorscheme<cr>", "Colorschemes"},
		["m"] = { "<cmd>Telescope marks<cr>", "Marks"},
		["."] = { "<cmd>Telescope file_browser<cr>", "Browse Files" },
		[":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
		["l"] = {
			name ="+LSP",
			["r"] = { "<cmd>Telescope lsp_references<cr>", "Lsp references" },
			["s"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols" },
			["w"] = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace symbols" },
			["y"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Dynamic workspace symbols" },
			["c"] = { "<cmd>Telescope lsp_code_actions<cr>", "Lsp code actions" },
			["d"] = { "<cmd>Telescope lsp_document_diagnostics<cr>", "Document diagnostics" },
			["g"] = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace diagnostics" },
		},
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

wk.setup(setup)
wk.register(mappings, { prefix = "<leader>" })
