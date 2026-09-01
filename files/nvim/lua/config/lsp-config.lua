-- LSP config
-------------
-- Neovim's native LSP client (vim.lsp.enable, 0.11+), servers installed
-- and enabled via Mason. Kept to a small generalist set on purpose (Carlos
-- mostly reads code/markdown, doesn't need a heavy IDE setup) but ready to
-- extend: add a server name to `servers` below and Mason installs it
-- automatically on next start, no other wiring needed.

require('mason').setup()

local servers = {
  'bashls',   -- bash/zsh
  'pyright',  -- python
  'lua_ls',   -- lua (also covers editing this nvim config)
  'marksman', -- markdown
  'jsonls',   -- json
  'yamlls',   -- yaml
}

require('mason-lspconfig').setup({
  ensure_installed = servers,
  automatic_enable = true,
})

-- lua_ls doesn't know about Neovim's `vim` global by default, so without
-- this every nvim config file gets a false "undefined global vim" warning.
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>li', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>ln', function() vim.diagnostic.jump({ count = 1 }) end, opts)
    vim.keymap.set('n', '<leader>lp', function() vim.diagnostic.jump({ count = -1 }) end, opts)
  end,
})
