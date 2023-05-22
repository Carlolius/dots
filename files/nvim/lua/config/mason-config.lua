------------------
-- Mason config --
------------------

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	vim.notify("Couldn't load Mason" .. mason, "error")
	return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
	vim.notify("Couldn't load Mason-LSP-Config" .. mason_lspconfig, "error")
	return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	vim.notify("Couldn't load LSP-Config" .. lspconfig, "error")
	return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
	vim.notify("Couldn't load CMP" .. cmp_nvim_lsp, "error")
	return
end

local lsp_defaults = lspconfig.util.default_config

mason.setup({
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

mason_lspconfig.setup_handlers(handlers)

lsp_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lsp_defaults.capabilities,
	cmp_nvim_lsp.default_capabilities()
)
