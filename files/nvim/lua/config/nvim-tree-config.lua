-- Nvim Tree config
-------------------

vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}
require'nvim-tree'.setup {
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = true,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	update_focused_file = {enable = true, update_cwd = true, ignore_list = {}},
	render = {
		indent_markers = {enable = true}
	},
	filters = {
		custom = {'*.tmp', '.git'}
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
		auto_resize = true,
		mappings = {custom_only = false,
			list = {}
		},
		number = false,
		relativenumber = false,
	}
}
