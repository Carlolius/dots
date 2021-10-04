local colors ={
    bg = '#2c323c',
    fg = '#FFFFFF',
    yellow = '#FBB829',
    cyan = '#0AAEB3',
    darkblue = '#2C78BF',
    green = '#519F50',
    orange = '#F75341',
    violet = '#FF5C8F',
    magenta = '#E02C6D',
    blue = '#68A8E4';
    red = '#EF2F27';
}

local vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.blue,
    VISUAL = colors.violet,
    OP = colors.green,
    BLOCK = colors.blue,
    REPLACE = colors.red,
    ['V-REPLACE'] = colors.red,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.magenta,
    SHELL = colors.green,
    TERM = colors.blue,
    NONE = colors.yellow
}

local vi_mode_text = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    [''] = "V-BLOCK",
    V = "V-LINE",
    c = "COMMAND",
    no = "UNKNOWN",
    s = "UNKNOWN",
    S = "UNKNOWN",
    ic = "UNKNOWN",
    R = "REPLACE",
    Rv = "UNKNOWN",
    cv = "UNKWON",
    ce = "UNKNOWN",
    r = "REPLACE",
    rm = "UNKNOWN",
    t = "INSERT"
}

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'UNIX' then
        icon = ' '
    elseif os == 'MAC' then
        icon = ' '
    else
        icon = ' '
    end
    return icon .. os
end

local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'

-- LuaFormatter off
local vi_mode = {
	left = {
		provider = function()
			local current_text = ' '..vi_mode_text[vim.fn.mode()]..' '
			return current_text
		end,
		hl = function()
			local val = {
				name = vi_mode_utils.get_mode_highlight_name(),
				fg = colors.bg,
				bg = vi_mode_utils.get_mode_color(),
				style = 'bold'
			}
			return val
		end
	},
	right = {
		provider = '▊',
		hl = function()
			local val = {
				name = vi_mode_utils.get_mode_highlight_name(),
				fg = vi_mode_utils.get_mode_color()
			}
			return val
		end,
		left_sep = ' '
	}
}


local file = {
	info = {
		provider = 'file_info',
		priority = 5,
		left_sep = ' ',
		file_modified_icon = '﯂',
		hl = {
			fg = colors.blue,
			style = 'bold'
		}
	},
	encoding = {
		provider = 'file_encoding',
		truncate_hide = true,
		left_sep = ' ',
		hl = {
			fg = colors.violet,
			style = 'bold'
		}
	},
	type = {
		provider = 'file_type',
		truncate_hide = true,
		left_sep = ' ',
		hl = {
			fg = colors.violet,
			style = 'bold'
		}
	},
	os = {
		provider = file_osinfo,
		truncate_hide = true,
		priority = -5,
		left_sep = ' ',
		hl = {
			fg = colors.green,
			style = 'bold'
		}
	},
	size = {
		provider = 'file_size',
		truncate_hide = true,
		left_sep = {
			str = '  ',
			hl = {
				fg = colors.violet
			}
		},
		right_sep = ' ',
		hl = {
			fg = colors.violet,
			style = 'bold'
		}
	}
}


local line_percentage = {
	provider = 'line_percentage',
	truncate_hide = true,
	left_sep = ' ',
	hl = {
		style = 'bold'
	}
}


local position = {
	all = {
		provider = function()
			return string.format(" %4i /%4i  %3i /%3i ", vim.fn.line('.'),vim.fn.line('$'),vim.fn.col('.'),string.len(vim.fn.getline('.')))
		end,
		-- icon = ' ',
		priority = 5,
		short_provider = 'position',
		left_sep = ' ',
		hl = {
			fg = colors.fg,
			bg = colors.darkblue,
			style = 'bold'
		},
	},
	line = {
		provider = function()
			return string.format("%4i /%4i", vim.fn.line('.'),vim.fn.line('$'))
		end,
		icon = ' ',
		priority = 5,
		short_provider = 'position',
		left_sep = ' ',
		hl = {
			fg = colors.fg,
			bg = colors.darkblue,
			style = 'bold'
		},
	},
	column = {
		provider = function()
			return string.format("%3i /%3i ", vim.fn.col('.'),string.len(vim.fn.getline('.')))
		end,
		icon = '  ',
		truncate_hide = true,
		hl = {
			fg = colors.fg,
			bg = colors.darkblue,
			style = 'bold'
		}
	},
}


local scroll_bar = {
	provider = 'scroll_bar',
	truncate_hide = true,
	left_sep = ' ',
	hl = {
		fg = colors.blue,
		style = 'bold'
	}
}


local diagnos = {
	err = {
		provider = 'diagnostic_errors',
		enabled = function()
			return lsp.diagnostics_exist('Error')
		end,
		hl = {
			fg = colors.red
		}
	},
	warn = {
		provider = 'diagnostic_warnings',
		enabled = function()
			return lsp.diagnostics_exist('Warning')
		end,
		hl = {
			fg = colors.yellow
		}
	},
	hint = {
		provider = 'diagnostic_hints',
		enabled = function()
			return lsp.diagnostics_exist('Hint')
		end,
		hl = {
			fg = colors.cyan
		}
	},
	info = {
		provider = 'diagnostic_info',
		enabled = function()
			return lsp.diagnostics_exist('Information')
		end,
		hl = {
			fg = colors.blue
		}
	},
}


local flsp = {
	name = {
		provider = 'lsp_client_names',
		left_sep = ' ',
		icon = ' ',
		hl = {
			fg = colors.yellow
		}
	}
}


local git = {
	branch = {
		provider = 'git_branch',
		icon = ' ',
		left_sep = ' ',
		hl = {
			fg = colors.violet,
			style = 'bold'
		},
	},
	add = {
		provider = 'git_diff_added',
		hl = {
			fg = colors.green
		}
	},
	change = {
		provider = 'git_diff_changed',
		hl = {
			fg = colors.orange
		}
	},
	remove = {
		provider = 'git_diff_removed',
		hl = {
			fg = colors.red
		}
	}
}

local components = {
	active = {},
	inactive = {}
}

components.active[1] = {
	vi_mode.left,
	file.info,
	file.type,
	file.size,
	flsp.name
}

components.inactive[1] = {
	file.info
}

components.active[2] = {
	diagnos.err,
	diagnos.warn,
	diagnos.hint,
	diagnos.info,
	git.branch,
	git.add,
	git.change,
	git.remove,
}
components.inactive[2] = {
}
components.active[3] = {
	file.encoding,
	file.os,
	scroll_bar,
	line_percentage,
	position.all,
	--[[ position.line,
	position.column, ]]
}
components.inactive[3] = {
	file.os
}

-- LuaFormatter on

require'feline'.setup {
    bg = colors.bg,
    fg = colors.fg,
    components = components,
    vi_mode_colors = vi_mode_colors,
    force_inactive = {
        filetypes = {
            'NvimTree',
            'dbui',
            'packer',
            'startify',
            'fugitive',
            'fugitiveblame'
        },
        buftypes = {'terminal'},
        bufnames = {}
    }
}
