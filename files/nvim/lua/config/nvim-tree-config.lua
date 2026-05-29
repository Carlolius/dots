-- Nvim Tree config
-------------------

vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    vim.opt_local.statusline = " "
  end,
})

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = true,
	sync_root_with_cwd = true,
	update_focused_file = { enable = true, update_cwd = false },
	filters = {
		custom = { "*.tmp", ".git" },
	},
	actions = {
		open_file = {
			resize_window = false,
		},
	},
	renderer = {
		indent_markers = { enable = true },
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
	},
	diagnostics = { enable = false },
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 25,
		side = "left",
		relativenumber = false,
	},
})
