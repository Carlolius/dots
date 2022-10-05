-- Null ls config
-----------------

local null_ls = require("null-ls")
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		-- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		-- -- formatting.yapf,
		-- formatting.stylua,
		-- formatting.autopep8,
		-- diagnostics.flake8,
		-- formatting.rubocop,
		-- -- diagnostics.rubocop,
		-- null_ls.builtins.diagnostics.editorconfig_checker.with({ command = "editorconfig-checker" }),
		null_ls.builtins.diagnostics.actionlint,
		null_ls.builtins.diagnostics.codespell,
		null_ls.builtins.diagnostics.gitlint,
		null_ls.builtins.diagnostics.misspell,
		null_ls.builtins.diagnostics.selene,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.yamllint,
		null_ls.builtins.formatting.cbfmt,
		null_ls.builtins.formatting.jq,
		null_ls.builtins.formatting.ktlint,
		null_ls.builtins.formatting.markdownlint,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.formatting.stylua,
	},
})
