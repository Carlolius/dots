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

local comps = {
    vi_mode = {
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
    },
    file = {
        info = {
            provider = 'file_info',
            hl = {
                fg = colors.blue,
                style = 'bold'
            },
            left_sep = ' '
        },
        encoding = {
            provider = 'file_encoding',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        type = {
            provider = 'file_type',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        os = {
            provider = file_osinfo,
            left_sep = ' ',
            hl = {
                fg = colors.green,
                style = 'bold'
            }
        },
		size = {
			provider = 'file_size',
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
    },
    line_percentage = {
        provider = 'line_percentage',
        left_sep = ' ',
        hl = {
            style = 'bold'
        }
    },
	position = {
		line = {
			provider = function()
				return string.format("%4i /%4i", vim.fn.line('.'),vim.fn.line('$'))
			end,
			icon = ' ',
			left_sep = ' ',
			hl = {
				fg = colors.fg,
				bg = colors.darkblue,
				style = 'bold'
			}
		},
		column = {
			provider = function()
				return string.format("%3i /%3i ", vim.fn.col('.'),string.len(vim.fn.getline('.')))
			end,
			icon = '  ',
			hl = {
				fg = colors.fg,
				bg = colors.darkblue,
				style = 'bold'
			}
		},
	},
    scroll_bar = {
        provider = 'scroll_bar',
        left_sep = ' ',
        hl = {
            fg = colors.blue,
            style = 'bold'
        }
    },
    diagnos = {
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
    },
    lsp = {
        name = {
            provider = 'lsp_client_names',
            left_sep = ' ',
            icon = ' ',
            hl = {
                fg = colors.yellow
            }
        }
    },
    git = {
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
}

local components = {
	active = {},
	inactive = {}
}

components.active[1] = {
	comps.vi_mode.left,
	comps.file.info,
	comps.file.type,
	comps.file.size,
	comps.lsp.name
}

components.inactive[1] = {
	comps.file.info
}

components.active[2] = {
	comps.diagnos.err,
	comps.diagnos.warn,
	comps.diagnos.hint,
	comps.diagnos.info
}
components.inactive[2] = {
}
components.active[3] = {
	comps.git.add,
	comps.git.change,
	comps.git.remove,
	comps.git.branch,
	comps.file.encoding,
	comps.file.os,
	comps.scroll_bar,
	comps.line_percentage,
	comps.position.line,
	comps.position.column,
}
components.inactive[3] = {
	comps.file.os
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
