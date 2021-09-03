local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = {" "}

local colors = {
    bg = "#282c34",
    line_bg = "#282c34",
    fg = "#D8DEE9",
    fg_green = "#65a380",
    yellow = "#A3BE8C",
    cyan = "#22262C",
    darkblue = "#61afef",
    green = "#BBE67E",
    orange = "#FF8800",
    purple = "#252930",
    magenta = "#c678dd",
    blue = "#22262C",
    red = "#DF8890",
    lightbg = "#3C4048",
    nord = "#81A1C1",
    greenYel = "#EBCB8B"
}
local condition = require('galaxyline.condition')

gls.left[1] = {
    ViMode = {
        provider = function()
            local alias = {
                n = " NORMAL ",
                i = " INSERT ",
                c = " COMMAND ",
                V = " VISUAL ",
                s = " SELECT ",
                S = " SELECT ",
                [""] = " VISUAL ",
                v = " VISUAL ",
                R = " REPLACE "
            }
						local mode_color = {
													n = colors.darkblue,
													i = colors.red,
													v=colors.nord,
													[''] = colors.nord,
													V=colors.nord,
                          c = colors.magenta,no = colors.red,s = colors.magenta,
                          s=colors.magenta,[''] = colors.magenta,
                          S=colors.magenta,[''] = colors.magenta,
                          ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                          cv = colors.red,ce=colors.red, r = colors.cyan,
                          rm = colors.cyan, ['r?'] = colors.cyan,
                          ['!']  = colors.red,t = colors.red}
						local stat_color = mode_color[vim.fn.mode()]
						if stat_color == nil then
							stat_color = colors.darkblue
						end
						vim.api.nvim_command('hi GalaxyViMode guibg='..stat_color)
            return alias[vim.fn.mode()]
        end,
				icon = " ",
        separator = " ",
        separator_highlight = {colors.lightbg, colors.lightbg},
        highlight = {colors.lightbg, colors.fg, 'bold'}
    }
}

gls.left[3] = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
    }
}

gls.left[4] = {
    getCwd = {
        provider = function ()
            -- local full_dir = vim.fn.expand('%:p') -- full file path
			-- http://vimdoc.sourceforge.net/htmldoc/cmdline.html#filename-modifiers
			local project_dir = vim.fn.getcwd()
			-- local project_dir = vim.fn.expand("%:p:~") - abs file path with ~/ format
			-- local home_dir = os.getenv("HOME")
			-- local abs_file_path = vim.fn.expand("%:p") -- #str - length -- relative path to pdir (or absolute smtim)
			local rel_file_dir = vim.fn.expand("%:p:~:.") -- #str - length -- relative path to pdir (or absolute smtim)

			-- project_dir = project_dir:gsub(home_dir, '~')
			-- project_dir = vim.fn.expand("%:p:h")
			-- project_dir = project_dir:gsub('(%w)[%w|%s|_]*','%1.')..'> '
			if #project_dir > 15 then
				local cut_idx = #project_dir - project_dir:reverse():find('/') + 1
				if cut_idx then
					project_dir ="."..project_dir:sub(cut_idx, -1)..'//'  -- show only last 25 digits
				else
					project_dir ="."..project_dir:sub(-10, -1)..'//'
				end
			else
				project_dir = project_dir..'/'
			end

			return project_dir..rel_file_dir.." "
		end,
        condition = condition.buffer_not_empty,
        highlight = {colors.fg, colors.lightbg}
    }
}
local gps = require("nvim-gps")

gls.left[5] = {
    nvimGPS = {
			provider = function()
				return gps.get_location()
			end,
			condition = function()
				return gps.is_available()
			end,
			highlight = {colors.green, colors.lightbg}
	}
}
-- gls.left[5] = {
--     FileName = {
--         provider = {"FileName", "FileSize"},
--         condition = condition.buffer_not_empty,
--         highlight = {colors.fg, colors.lightbg}
--     }
-- }

gls.left[6] = {
    teech = {
        provider = function()
            return ""
        end,
        separator = " ",
        highlight = {colors.lightbg, colors.bg}
    }
}

-- local checkwidth = function()
--     local squeeze_width = vim.fn.winwidth(0) / 2
--     return squeeze_width > 20 and true or false
-- end

gls.left[7] = {
    DiffAdd = {
        provider = "DiffAdd",
        -- condition = checkwidth,
        icon = "   ",
        highlight = {colors.greenYel, colors.line_bg}
    }
}

gls.left[8] = {
    DiffModified = {
        provider = "DiffModified",
        -- condition = checkwidth,
        icon = " ",
        highlight = {colors.orange, colors.line_bg}
    }
}

gls.left[9] = {
    DiffRemove = {
        provider = "DiffRemove",
        -- condition = checkwidth,
        icon = " ",
        highlight = {colors.red, colors.line_bg}
    }
}

gls.left[10] = {
    LeftEnd = {
        provider = function()
            return " "
        end,
        separator = " ",
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[11] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}

gls.left[12] = {
    Space = {
        provider = function()
            return " "
        end,
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[13] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.blue, colors.bg}
    }
}

gls.right[1] = {
	ShowLspClient = {
		provider = "GetLspClient",
		-- icon = "  ",
		condition = condition.buffer_not_empty,
		icon = 'LSP:',
		highlight = {colors.green, colors.bg}
	}
}


gls.right[2] = {
    GitIcon = {
        provider = function()
            return "       "
        end,
        condition = condition.check_git_workspace,
        highlight = {colors.green, colors.line_bg}
    }
}

gls.right[3] = {
    GitBranch = {
        provider = "GitBranch",
        condition = condition.check_git_workspace,
        highlight = {colors.green, colors.line_bg}
    }
}



gls.right[5] = {
    PerCent = {
        provider = "LinePercent",
        separator = " ",
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.bg, colors.darkblue, 'bold'}
    }
}


