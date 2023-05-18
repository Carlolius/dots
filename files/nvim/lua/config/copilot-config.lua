require("copilot").setup {
	panel = {
		enabled = true,
		auto_refresh = true,
		keymap = {
			jump_prev = "[[",
			jump_next = "]]",
			accept = "<CR>",
			refresh = "gr",
			open = "<M-CR>"
		},
		layout = {
			position = "bottom", -- | top | left | right
			ratio = 0.4
		},
	},
	server_opts_overrides = {
		trace = "verbose",
		settings = {
			advanced = {
				listCount = 10, -- #completions for panel
				inlineSuggestCount = 5, -- #completions for getCompletions
			}
		},
	}
}
