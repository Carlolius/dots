require'nvim-treesitter.configs'.setup {
	-- one of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = {
		"bash",
		"bibtex",
		"html",
		"java",
		"javascript",
		"json",
		"latex",
		"lua",
		"python",
		"regex",
		"typescript",
	},
	highlight = {
		enable = true,              -- false will disable the whole extension
		use_langutree = true,
		disable = { "c", "rust" },  -- list of language that will be disabled
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
}