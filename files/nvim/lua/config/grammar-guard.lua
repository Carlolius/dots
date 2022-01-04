require("lspconfig").grammar_guard.setup({
	settings = {
		ltex = {
			enabled = { "latex", "tex", "bib", "markdown" },
			language = "es",
			diagnosticSeverity = "information",
			setenceCacheSize = 2000,
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "es",
			},
			trace = { server = "verbose" },
			dictionary = {},
			disabledRules = {},
			hiddenFalsePositives = {},
		},
	},
})
