-- Toggleterm config
--------------------

require("toggleterm").setup({
	size = 20,
	hide_numbers = true,
	open_mapping = [[<F2>]],
	shade_filetypes = {},
	shade_terminals = false,
	shading_factor = 0.3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	start_in_insert = true,
	persist_size = true,
	direction = "float",
})

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

local horizontal = Terminal:new({
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 0.3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	start_in_insert = true,
	persist_size = true,
	direction = "horizontal",
})

local vertical = Terminal:new({
	size = 20,
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 0.3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	start_in_insert = true,
	persist_size = false,
	direction = "vertical",
})

function Lazygit_toggle()
	lazygit:toggle()
end
function Horizontal_toggle()
	horizontal:toggle()
end
function Vertical_toggle()
	vertical:toggle()
end

-- Esc twice to get to normal mode
vim.cmd([[tnoremap <esc><esc> <C-\><C-N>]])
