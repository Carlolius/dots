-- Editor Options
------------------
local set = vim.opt
local cmd = vim.cmd
local global = vim.g

-- Indentation
set.autoindent = true
set.smartindent = true
set.shiftwidth = 0 -- Use tabstop value
set.tabstop = 4
set.shiftround = true

-- Display
set.number = true
set.relativenumber = true
set.cursorline = true
set.signcolumn = "yes"
set.mouse = "a"
set.showbreak = "↪ "
set.listchars = {
  tab = "→ ",
  eol = "↲",
  nbsp = "␣",
  trail = "•",
  extends = "⟩",
  precedes = "⟨",
}

-- Behavior
set.backup = false
set.swapfile = false
set.undofile = true
set.writebackup = false
set.hidden = true
set.foldlevel = 5

-- Search
set.ignorecase = true
set.smartcase = true
set.hlsearch = true
set.incsearch = true

-- UI
set.wildmenu = true
set.wildmode = { "longest:full", "full" }
set.completeopt = { "menuone", "preview", "noinsert", "noselect" }

-- Clipboard & Syntax
set.clipboard = "unnamedplus"
set.syntax = "on"
set.formatoptions = "jcroqlnt"

-- Terminal & Colors
set.termguicolors = true
cmd([[colorscheme onedark_dark]])
cmd([[highlight TabLineSel guibg=#454545]])


-- No plugin here needs a Python/Node/Perl remote-plugin host (everything is
-- pure Lua) — disable those providers instead of leaving them half-detected
-- and warning on every :checkhealth.
global.loaded_python3_provider = 0
global.loaded_node_provider = 0
global.loaded_perl_provider = 0
