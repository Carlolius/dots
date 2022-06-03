-- LSP configuration
--------------------

local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

require("lspconfig")
require("config.lsp.handlers").setup()

-- Solargraph doesn't work well with lsp-installer.
-- Install with gem install solargraph, and add the gems to the PATH.
require'lspconfig'.solargraph.setup{}

local lspconfig = require("lspconfig")

-- Include the servers you want to have installed by default below
local servers = {
	"angularls",
	"bashls",
	"dockerls",
	"html",
	"jsonls",
	"ltex",
	"pyright",
	-- "solargraph",
	"sumneko_lua",
	"texlab",
	"tsserver",
}

lsp_installer.setup({
	ensure_installed = servers,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("config.lsp.handlers").on_attach,
		capabilities = require("config.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "config.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end
	lspconfig[server].setup(opts)
end
