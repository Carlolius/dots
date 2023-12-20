-- Nvim Tree config
-------------------

require'nvim-tree'.setup {
	disable_netrw = true,
	hijack_netrw = true,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	update_focused_file = {enable = false, update_root = true, ignore_list = {}},
	actions = {
		open_file = {
			resize_window = false,
		},
	},
	renderer = {
		indent_markers = {enable = true},
	},
	diagnostics = {
		enable = true
	},
	modified = {
		enable = true
	},
	git = {
		enable = true,
		timeout = 500,
	},
	system_open = {
		-- the command to run this, leaving nil should work in most cases
		cmd = nil,
		-- the command arguments as a list
		args = {}
	},
	view = {
		width = 30,
		side = 'left',
		preserve_window_proportions = true
	}
}
