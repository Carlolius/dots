-- Cmp config
-------------

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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
	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		documentation = {
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
