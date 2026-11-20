-- Autocommands
----------------
local cmd = vim.cmd

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank({ on_visual = false }) end,
})

-- Treesitter highlighting: the new nvim-treesitter API does not enable it on
-- its own. pcall: filetypes without an installed parser just keep regex syntax.
-- The filetype -> parser mapping is registered by nvim-treesitter, which loads
-- later than the first FileType event, so declare the ones we need up front.
vim.treesitter.language.register("bash", "sh")
vim.treesitter.language.register("json", "jsonc")
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev) pcall(vim.treesitter.start, ev.buf) end,
})

-- Toggle relativenumber based on focus
cmd([[
augroup number_toggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END
]])
