-- Keybinds config
------------------

-- General keybinds the other ones are in WhichKey plugin configuration
-- Local var
local keymap = vim.api.nvim_set_keymap
-- Map leader to space
vim.g.mapleader = " "
-- Quickly cancel search highlighting
keymap("n", "<Leader><space>", ":nohlsearch<cr>", { noremap = true })
-- jk and kj = to esc
keymap("i", "jk", "<ESC>", { noremap = true })
keymap("i", "kj", "<ESC>", { noremap = true })
-- Navigate tabs
keymap("n", "<S-l>", ":tabnext<CR>", { noremap = true })
keymap("n", "<S-h>", ":tabprevious<CR>", { noremap = true })
-- Navigate buffers
keymap("n", "<S-j>", ":bnext<CR>", { noremap = true })
keymap("n", "<S-k>", ":bprevious<CR>", { noremap = true })
-- Move text in visual mode with J/K
keymap("v", "<A-j>", [[:m '>+1<CR>gv=gv]], { noremap = true })
keymap("v", "<A-k>", [[:m '<-2<CR>gv=gv]], { noremap = true })
-- Indent in visual mode
keymap("v", "<A-l>", ">+1<CR>gv-gv", { noremap = true })
keymap("v", "<A-h>", "<-2<CR>gv-gv", { noremap = true })
