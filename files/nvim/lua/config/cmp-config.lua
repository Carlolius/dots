local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col "." - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match "%s" ~= nil
end

local cmp = require "cmp"
local luasnip = require("luasnip")

cmp.setup {
	formatting = {
		fields = {"kind", "abbr", "menu"},
		format = function(entry, vim_item)
			-- fancy icons and a name of kind
			vim_item.kind = string.format (
			"%s", -- With 2 %s shows the string with the name
			require("config.icons").icons[vim_item.kind],
			vim_item.kind
			)
			-- set a name for each source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
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
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(t("<C-n>"), "n")
			elseif luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
			elseif check_back_space() then
				vim.fn.feedkeys(t("<Tab>"), "n")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(t("<C-p>"), "n")
			elseif luasnip.jumpable(-1) then
				vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	documentation = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "treesitter" },
		{ name = "buffer", default = 5 },
		{ name = "calc" },
		{ name = "emoji" },
	},
}

-- Autopairs
require("cmp").setup({
	map_cr = true,
	map_complete = true,
	auto_select = true
})

require("luasnip.loaders.from_vscode").lazy_load() -- load the other snippets line "friendly snippets"
