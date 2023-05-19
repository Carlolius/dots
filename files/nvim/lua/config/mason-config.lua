local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

local handlers = {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		local opts = {
			on_attach = require("config.lsp.handlers").on_attach,
			capabilities = require("config.lsp.handlers").capabilities,
		}
		local has_custom_opts, server_custom_opts = pcall(require, "config.lsp.settings." .. server_name)
		if has_custom_opts then
			opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
		end
		lspconfig[server_name].setup(opts)
	end
}

require('mason-lspconfig').setup_handlers(handlers)

lsp_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lsp_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)
