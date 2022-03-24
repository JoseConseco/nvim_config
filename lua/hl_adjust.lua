P = function(v)
	print(vim.inspect(v))
	return v
end

local fmt = string.format

local function get_color_from_hl(name)
  local result = {}
  for k, v in pairs(vim.api.nvim_get_hl_by_name(name, true)) do
		if type(v) == 'number' then
			result[k] = fmt("#%06x", v)
		elseif type(v) == 'boolean' then
			result[k] = v
		end
  end
  return result
end

local function to_rgb(color)
	if color ~= nil then
		return tonumber(color:sub(2, 3), 16), tonumber(color:sub(4, 5), 16), tonumber(color:sub(6), 16)
	end
end

local function clamp_color(color)
  return math.max(math.min(color, 255), 0)
end

-- https://stackoverflow.com/a/13532993
local function adjust_color(color, percent)
  local r, g, b = to_rgb(color)
  r = clamp_color(math.floor(tonumber(r * (100 + percent) / 100)))
  g = clamp_color(math.floor(tonumber(g * (100 + percent) / 100)))
  b = clamp_color(math.floor(tonumber(b * (100 + percent) / 100)))

  return "#" .. fmt("%0x", r) .. fmt("%0x", g) .. fmt("%0x", b)
end

local function highlight(group, color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local sp = color.sp and "guisp=" .. color.sp or ""
  local hl = "highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp
  vim.cmd(hl)
end

function _G.gen_hl(new_highlight, in_highlight)
  local normal = get_color_from_hl(in_highlight)
	if normal.background == nil then
		print("No background color for " .. in_highlight)
		return
	end
	local r, g, b = to_rgb(normal.background)
	local factor = -6
	if r + g + b < 255+127 then
		factor = 30
	end

	local new_color = adjust_color(normal.background, factor) -- darken by 10%


  local groups = {
    [new_highlight] = { bg = new_color },
  }

  for name, values in pairs(groups) do
    highlight(name, values)
  end
end

