-- Keybinds config
------------------

-- General keybinds the other ones are in WhichKey plugin configuration
-- Map leader to space
vim.g.mapleader = " "
-- Quickly cancel search highlighting
vim.api.nvim_set_keymap('n', '<Leader><space>', ':nohlsearch<cr>', { noremap = true} )
-- jk = to esc
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true } )
-- kj = to esc
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', { noremap = true } )
