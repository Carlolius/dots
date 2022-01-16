-- LSP configuration
--------------------

require("lspconfig")
require("config.lsp.handlers").setup()
require("config.lsp.null-ls")

local lsp_installer = require("nvim-lsp-installer")

-- Include the servers you want to have installed by default below
local servers = {
	"angularls",
	"bashls",
	"html",
	"jsonls",
	"ltex",
	"pyright",
	"sumneko_lua",
	"texlab",
	"tsserver",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
		on_attach = require("config.lsp.handlers").on_attach,
		capabilities = require("config.lsp.handlers").capabilities,
	}

	-- JSON
	 if server.name == "jsonls" then
	 	local jsonls_opts = require("config.lsp.settings.jsonls")
	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	 end

	-- Sumneko_lua
	 if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("config.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	 end

	-- Ltex & Grammar guard
	 if server.name == "ltex" then
		require("grammar-guard").init()
		local grammarguard = require("config.lsp.settings.grammarguard")
		opts = vim.tbl_deep_extend("force", grammarguard, opts)
	end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
