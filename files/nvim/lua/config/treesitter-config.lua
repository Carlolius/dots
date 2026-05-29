-- Treesitter config (new API)
-----------------------------

require("nvim-treesitter").setup()

-- Install parsers on first load
local parsers = {
  "bash", "dockerfile", "html", "javascript",
  "json", "lua", "markdown", "markdown_inline",
  "python", "regex", "typescript",
}

for _, lang in ipairs(parsers) do
  if not pcall(vim.treesitter.language.inspect, lang) then
    vim.cmd("TSInstall " .. lang)
  end
end

-- Folds via treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
