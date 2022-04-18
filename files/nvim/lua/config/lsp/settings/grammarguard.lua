-- Grammar Guard config
-----------------------

return({
	settings = {
		ltex = {
			enabled = { "latex", "tex", "bib", "markdown" },
			-- English: en
			-- language = "en",
			-- Spanish: es
			language = "es",
			-- Galician: gl-ES
			-- language = "gl-ES",
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
