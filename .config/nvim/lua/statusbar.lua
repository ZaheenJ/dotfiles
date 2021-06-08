local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local gls = gl.section
-- gl.short_line_list = {'NvimTree','packer'}

local colors = {
	bg = 'NONE',
	fg = "#ffffff",
	yellow = '#ffff00',
	green = '#00ff00',
	orange = '#ff7f00',
	magenta = '#ff00ff',
	purple = '#7F007F',
	gray = '#444444',
	blue = '#0000ff',
	red = '#ff0000',
	cyan = '#00ffff',
}
local fileColor = require('galaxyline.provider_fileinfo').get_file_icon_color

gls.left[1] = {
	ViMode = {
		provider = function()
			-- auto change color according the vim mode
			local mode_color = {
				n = colors.blue,
				i = colors.green,
				v = colors.magenta,
				[''] = colors.magenta,
				V = colors.magenta,
				c = colors.gray,
				no = colors.blue,
				s = colors.orange,
				S = colors.orange,
				[''] = colors.orange,
				ic = colors.yellow,
				R = colors.red,
				Rv = colors.red,
				cv = colors.blue,
				ce = colors.blue,
				r = colors.cyan,
				rm = colors.cyan,
				['r?'] = colors.cyan,
				['!'] = colors.blue,
				t = colors.blue
			}
			vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
			return '▊'
		end,
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.red, colors.bg}
	}
}

gls.left[2] = {
	PerCent = {
		provider = 'LinePercent',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.magenta,colors.bg},
	}
}

gls.left[3] = {
	LineInfo = {
		provider = 'LineColumn',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.blue,colors.bg},
	},
}

gls.left[4] = {
	FileIcon = {
		provider = 'FileIcon',
		condition = condition.buffer_not_empty,
		highlight = {fileColor,colors.bg},
	}
}

gls.left[5] = {
	FileName = {
		provider = 'FileName',
		condition = condition.buffer_not_empty,
		highlight = {fileColor,colors.bg}
	}
}

gls.right[1] = {
	DiagnosticError = {
		provider = 'DiagnosticError',
		icon = '  ',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.red,colors.bg}
	}
}
gls.right[2] = {
	DiagnosticWarn = {
		provider = 'DiagnosticWarn',
		icon = '  ',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.yellow,colors.bg},
	}
}

gls.right[3] = {
	DiagnosticHint = {
		provider = 'DiagnosticHint',
		icon = '  ',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.cyan,colors.bg},
	}
}

gls.right[4] = {
	DiagnosticInfo = {
		provider = 'DiagnosticInfo',
		icon = '  ',
		separator = ' ',
		separator_highlight = {'NONE',colors.bg},
		highlight = {colors.blue,colors.bg},
	}
}

gls.right[5] = {
	DiffAdd = {
		provider = 'DiffAdd',
		condition = condition.hide_in_width,
		icon = '  ',
		--[[ separator = ' ',
		separator_highlight = {'NONE',colors.bg}, ]]
		highlight = {colors.green,colors.bg},
	}
}
gls.right[6] = {
	DiffModified = {
		provider = 'DiffModified',
		condition = condition.hide_in_width,
		icon = ' 柳',
		--[[ separator = ' ',
		separator_highlight = {'NONE',colors.bg}, ]]
		highlight = {colors.orange,colors.bg},
	}
}
gls.right[7] = {
	DiffRemove = {
		provider = 'DiffRemove',
		condition = condition.hide_in_width,
		icon = '  ',
		--[[ separator = ' ',
		separator_highlight = {'NONE',colors.bg}, ]]
		highlight = {colors.red,colors.bg},
	}
}

gls.right[8] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.orange,colors.bg,},
  }
}

gls.right[9] = {
	GitBranch = {
		provider = 'GitBranch',
		condition = condition.check_git_workspace,
		--[[ separator = ' ',
		separator_highlight = {'NONE',colors.bg}, ]]
		highlight = {colors.orange,colors.bg},
	}
}

gls.right[10] = {
	Whitespace = {
		provider = function()
			return ' '
		end,
		highlight = {colors.bg, colors.bg},
	},
}

gls.right[11] = {
	BufIcon = {
		provider = "BufferIcon",
		highlight = {colors.fg, colors.bg}
	}
}
