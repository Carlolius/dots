local mason_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_status_ok then
	vim.notify("Couldn't load Mason-LSP-Config" .. mason_lspconfig, "error")
	return
end

-- Extension to bridge mason.nvim with the lspconfig plugin
mason_lspconfig.setup({
	-- A list of servers to automatically install if they're not already installed.
	ensure_installed = {
		"jsonls",
		"luau_lsp",
		"pyright",
		"vimls",
		"yamlls",
	},
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	vim.notify("Couldn't load LSP-Config" .. lspconfig, "error")
	return
end

local opts = {
	-- on_attach = require("config.lsp.lsp").on_attach,
	-- capabilities = require("config.lsp.lsp").capabilities,
}

mason_lspconfig.setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- Default handler (optional)
		lspconfig[server_name].setup({
			on_attach = opts.on_attach,
			capabilities = opts.capabilities,
		})
	end,

	-- Next, you can provide targeted overrides for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	["rust_analyzer"] = function()
		require("rust-tools").setup({})
	end,

	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			on_attach = opts.on_attach,
			capabilities = opts.capabilities,

			settings = {
				Lua = {
					-- Tells Lua that a global variable named vim exists to not have warnings when configuring neovim
					diagnostics = {
						globals = { "vim" },
					},

					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end,

	["pyright"] = function()
		lspconfig.pyright.setup({
			on_attach = opts.on_attach,
			capabilities = opts.capabilities,

			settings = {
				python = {
					analysis = {
						-- Disable strict type checking
						typeCheckingMode = "off",
					},
				},
			},
		})
	end,

	["jsonls"] = function()
		-- Find more schemas here: https://www.schemastore.org/json/
		-- Schemas for common json files
		local schemas = {
			{
				description = "Schema for CMake Presets",
				fileMatch = {
					"CMakePresets.json",
					"CMakeUserPresets.json",
				},
				url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json",
			},
			{
				description = "LLVM compilation database",
				fileMatch = {
					"compile_commands.json",
				},
				url = "https://json.schemastore.org/compile-commands.json",
			},
			{
				description = "Config file for Command Task Runner",
				fileMatch = {
					"commands.json",
				},
				url = "https://json.schemastore.org/commands.json",
			},
			{
				description = "Json schema for properties json file for a GitHub Workflow template",
				fileMatch = {
					".github/workflow-templates/**.properties.json",
				},
				url = "https://json.schemastore.org/github-workflow-template-properties.json",
			},
			{
				description = "JSON schema for Visual Studio component configuration files",
				fileMatch = {
					"*.vsconfig",
				},
				url = "https://json.schemastore.org/vsconfig.json",
			},
		}

		lspconfig.jsonls.setup({
			on_attach = opts.on_attach,
			capabilities = opts.capabilities,

			settings = {
				json = {
					schemas = schemas,
				},
			},

			setup = {
				commands = {
					Format = {
						function()
							vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
						end,
					},
				},
			},
		})
	end,
})
