-- Autocommands
----------------
local cmd = vim.cmd

-- Highlight on yank
cmd([[ autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false} ]])

-- Toggle relativenumber based on focus
cmd([[
augroup number_toggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END
]])
