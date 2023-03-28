-- Keybinds config
------------------

-- General keybinds the other ones are in WhichKey plugin configuration
-- Local var
local keymap = vim.api.nvim_set_keymap
-- Map leader to space
vim.g.mapleader = " "
-- Quickly cancel search highlighting
keymap("n", "<Leader>c", ":nohlsearch<cr>", { noremap = true })
-- Quick search in buffer
keymap("n", "<Leader><space>", "<cmd>Telescope buffers<cr>", { noremap = true })
-- jk and kj = to esc
keymap("i", "jk", "<ESC>", { noremap = true })
keymap("i", "kj", "<ESC>", { noremap = true })
-- Navigate tabs
keymap("n", "<A-l>", ":tabnext<CR>", { noremap = true })
keymap("n", "<A-h>", ":tabprevious<CR>", { noremap = true })
-- Navigate buffers
keymap("n", "<A-j>", ":bnext<CR>", { noremap = true })
keymap("n", "<A-k>", ":bprevious<CR>", { noremap = true })
-- Move text in visual mode with J/K
keymap("v", "<A-S-j>", [[:m '>+1<CR>gv=gv]], { noremap = true })
keymap("v", "<A-S-k>", [[:m '<-2<CR>gv=gv]], { noremap = true })
-- Indent in visual mode
keymap("v", "<A-S-l>", ">+1<CR>gv-gv", { noremap = true })
keymap("v", "<A-S-h>", "<-2<CR>gv-gv", { noremap = true })
