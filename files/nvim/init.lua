-- My temporary nvim configuration
----------------------------------

-- Local var
local opt = vim.opt

-- Source files
---------------
require("key")
require("plugins")

-- Global options
----------------
opt.autoindent = true -- Indent correctly
opt.syntax = 'on'
opt.backup = false -- No backup file
opt.clipboard = "unnamedplus" -- Yank and paste outside Vim
opt.cursorline = true -- Show a line where cursor is
opt.hidden = true -- Enabe background buffers
opt.hlsearch = true -- Highlights search
opt.completeopt = "menuone,noselect"
opt.ignorecase = true -- Ignore search case
opt.incsearch = true -- Incremental search
opt.mouse = "a" -- Enable mouse
opt.number = true -- See the left row numbers
opt.relativenumber = true -- Set relative numbers
opt.shiftround = true -- Round indent
opt.shiftwidth =  0 -- Change the number of space characters inserted for indentation
opt.smartcase = true -- Don't ignorecase if upper chase characters
opt.smartindent = true -- Makes indenting smart
opt.swapfile = false -- No swap file
opt.syntax = 'on' -- Higlight syntax
opt.tabstop = 4 -- Spaces in tab
opt.undofile = true -- Allow undo even if the file has been closed
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.writebackup = false -- Do not backup file before write
vim.g.mapleader = " " -- Set mapleader
-- invisible characters to use on ':set list'
opt.listchars = {
  tab       = '→ '  ,
  eol       = '↲'   ,
  nbsp      = '␣'   ,
  trail     = '•'   ,
  extends   = '⟩'   ,
  precedes  = '⟨'   ,
  space     = '␣'   ,
}
opt.showbreak = '↪ '

-- Colors
---------
-- Enable 24 bits color
opt.termguicolors = true
-- vim.g.colors_name = 'gruvbox'
vim.cmd[[colorscheme gruvbox]]
vim.g.tokyonight_style = "night"

-- Autocomands
--------------
-- Highlight on yank
vim.cmd("au TextYankPost * lua vim.highlight.on_yank {}")
-- relative in normal mode, absolute in insert
-- From here: https://github.com/sum-catnip/nvim/tree/master/lua
-- af('BufEnter,FocusGained,InsertLeave', '*', function() vim.wo.relativenumber = true end)
-- af('BufLeave,FocusLost,InsertEnter',   '*', function() vim.wo.relativenumber = false end)
