-- Telescope config
-------------------

local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")

require("telescope").setup({
    defaults = {
		prompt_prefix = " ",

        mappings = {
            i = {
                ["<esc>"] = actions.close,
				["<M-p>"] = actions_layout.toggle_preview,
            },
        },
    },
})
