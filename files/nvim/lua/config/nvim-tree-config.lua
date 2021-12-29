vim.g.nvim_tree_ignore = {'*.tmp', '.git'}
vim.g.nvim_tree_indent_markers = 1
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
	auto_close = true,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	update_focused_file = {enable = true, update_cwd = true, ignore_list = {}},
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
