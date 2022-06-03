-- Cmp config
-------------

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- fancy icons and a name of kind
			vim_item.kind = string.format(
				"%s", -- With 2 %s shows the string with the name
				require("config.icons").icons[vim_item.kind],
				vim_item.kind
			)
			-- set a name for each source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				copilot = "[Copilot]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				look = "[Look]",
				path = "[Path]",
				spell = "[Spell]",
				calc = "[Calc]",
				emoji = "[Emoji]",
				treesitter = "[treesitter]",
			})[entry.source.name]
			return vim_item
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),

	-- `/` cmdline setup.
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	}),

	-- `:` cmdline setup.
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	}),

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		documentation = {
			-- cmp.config.window.bordered(),
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
		completion = {
			-- cmp.config.window.bordered()
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},
	sources = {
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "treesitter" },
		{ name = "buffer", default = 5 },
		{ name = "calc" },
		{ name = "emoji" },
	},
})

-- Autopairs
require("cmp").setup({
	map_cr = true,
	map_complete = true,
	auto_select = true,
})

require("luasnip.loaders.from_vscode").lazy_load() -- load the other snippets line "friendly snippets"
