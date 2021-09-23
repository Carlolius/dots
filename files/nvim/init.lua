-- My temporary nvim configuration
----------------------------------

-- Local var
local set = vim.opt -- options, same as set
local cmd = vim.cmd -- comand options
local global = vim.g -- global options

-- Source files
---------------
require("key")
require("plugins")

-- Global setions
----------------
set.autoindent = true -- Indent correctly
set.syntax = 'on'
set.backup = false -- No backup file
set.clipboard = "unnamedplus" -- Yank and paste outside Vim
set.cursorline = true -- Show a line where cursor is
set.hidden = true -- Enabe background buffers
set.hlsearch = true -- Highlights search
set.completeopt = {"menuone", "preview", "noinsert", "noselect"}
set.ignorecase = true -- Ignore search case
set.incsearch = true -- Incremental search
set.mouse = "a" -- Enable mouse
set.number = true -- See the left row numbers
set.relativenumber = true -- Set relative numbers
set.shiftround = true -- Round indent
set.shiftwidth =  0 -- Change the number of space characters inserted for indentation
set.smartcase = true -- Don't ignorecase if upper chase characters
set.smartindent = true -- Makes indenting smart
set.swapfile = false -- No swap file
set.syntax = 'on' -- Higlight syntax
set.tabstop = 4 -- Spaces in tab
set.undofile = true -- Allow undo even if the file has been closed
set.wildmode = {"longest:full,full"}  -- Command-line completion mode
set.writebackup = false -- Do not backup file before write
global.mapleader = " " -- Set mapleader
-- invisible characters to use on ':set list'
set.listchars = {
	tab       = '→ '  ,
	eol       = '↲'   ,
	nbsp      = '␣'   ,
	trail     = '•'   ,
	extends   = '⟩'   ,
	precedes  = '⟨'   ,
	space     = '␣'   ,
}
set.showbreak = '↪ '

-- Colors
---------
-- Enable 24 bits color
set.termguicolors = true
-- global.colors_name = 'gruvbox'
cmd[[colorscheme gruvbox]]
global.tokyonight_style = "night"

-- Autocomands
--------------
-- Highlight on yank
cmd [[ autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false} ]]

cmd [[
augroup recompile_plugins
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup END
]]

cmd [[
augroup number_toggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
]]

-- relative in normal mode, absolute in insert
-- From here: https://github.com/sum-catnip/nvim/tree/master/lua
-- af('BufEnter,FocusGained,InsertLeave', '*', function() vim.wo.relativenumber = true end)
-- af('BufLeave,FocusLost,InsertEnter',   '*', function() vim.wo.relativenumber = false end)
