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
			local project_dir = vim.fn.getcwd()
			local home_dir = os.getenv("HOME")
			local rel_file_dir = vim.fn.expand("%") -- #str - length -- relative path to pdir (or absolute smtim)

			project_dir = project_dir:gsub(home_dir, '~')
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

			return project_dir..rel_file_dir
		end,
        condition = condition.buffer_not_empty,
        highlight = {colors.fg, colors.lightbg}
    }
}
gls.left[5] = {
    bread_crumbs = {
        provider = function ()
			local bread = require('nvim-treesitter').statusline({
				indicator_size = 80,
				type_patterns = {'class','function', 'method'},
				transform_fn = function(line) return line:gsub('^.*%s(.*)[%(|%[|%{].*$','%1') end,
				separator = ' ▶ '
			})
			return  (bread and bread~='') and '  ▶ '..bread or ''
		end,
        condition = condition.buffer_not_empty,
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

gls.right[4] = {
    right_LeftRounded = {
        provider = function()
            return ""
        end,
        separator = " ",
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.red, colors.bg}
    }
}

gls.right[5] = {
    SiMode = {
        provider = function()
            local alias = {
                n = "NORMAL",
                i = "INSERT",
                c = "COMMAND",
                V = "VISUAL",
                [""] = "VISUAL",
                v = "VISUAL",
                R = "REPLACE"
            }
            return alias[vim.fn.mode()]
        end,
        separator = " ",
        highlight = {colors.bg, colors.red}
    }
}
gls.right[6] = {
    PerCent = {
        provider = "LinePercent",
        separator = " ",
        separator_highlight = {colors.red, colors.red},
        highlight = {colors.bg, colors.fg}
    }
}


gls.right[7] = {
    rightRounded = {
        provider = function()
            return ""
        end,
        highlight = {colors.fg, colors.bg}
    }
}
