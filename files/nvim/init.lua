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
cmd[[colorscheme onedarkpro]]
global.tokyonight_style = "night"

-- Python environment
if vim.fn.exists("$VIRTUAL_ENV") == 1 then
    global.python3_host_prog = vim.fn.substitute(vim.fn.system("which -a python3 | head -n2 | tail -n1"), "\n", "", "g")
else
    global.python3_host_prog = vim.fn.substitute(vim.fn.system("which python3"), "\n", "", "g")
end

-- Autocomands
--------------
-- Highlight on yank
cmd [[ autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false} ]]

-- Recompile after save plugins.lua
cmd [[
augroup recompile_plugins
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup END
]]

-- Toggle between relativenumber and number depending on focus
cmd [[
augroup number_toggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END
]]
