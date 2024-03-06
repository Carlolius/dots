-- Nvim Tree config
-------------------

require'nvim-tree'.setup {
	disable_netrw = true,
	hijack_netrw = true,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	update_focused_file = {enable = false, update_root = true, ignore_list = {}},
	filters = {
		custom = {'*.tmp', '.git'}
	},
	actions = {
		open_file = {
			resize_window = false,
		},
	},
	renderer = {
		indent_markers = {enable = true},
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				-- git = {
				-- 	unstaged = "",
				-- 	staged = "S",
				-- 	unmerged = "",
				-- 	renamed = "➜",
				-- 	deleted = "",
				-- 	untracked = "U",
				-- 	ignored = "◌",
				-- },
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		}
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		}
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	system_open = {
		-- the command to run this, leaving nil should work in most cases
		cmd = nil,
		-- the command arguments as a list
		args = {}
	},
	view = {
		width = 25,
		side = 'left',
		hide_root_folder = false,
		relativenumber = false,
	}
}
