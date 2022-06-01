local M = {}

P = function(v)
  print(vim.inspect(v))
  return v
end

local Color = require "nightfox.lib.color"

local fmt = string.format

local hex = function(decimal)
	    return fmt("#%06x", decimal)
end


local function get_color_from_hl(name)
  local result = {}
	-- local deb = vim.api.nvim_get_hl_by_name(name, true)
	-- P(deb)
  for k, v in pairs(vim.api.nvim_get_hl_by_name(name, true)) do
    if type(v) == "number" then
      result[k] = hex(v)
    elseif type(v) == "boolean" then
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
local function adjust_color(color, fac)
  local r, g, b = to_rgb(color)
  r = clamp_color(math.floor(tonumber(r * fac)))
  g = clamp_color(math.floor(tonumber(g * fac)))
  b = clamp_color(math.floor(tonumber(b * fac)))

  return "#" .. fmt("%0x", r) .. fmt("%0x", g) .. fmt("%0x", b)
end

local function write_highlight(name, style)
	vim.api.nvim_set_hl(0, name, style)
end

---Match base_color lightness to reference highlight, and create new highlight from it
---@param base_color string hex color
---@param ref_highlight string highlight name
---@param new_highlight_name string new highlight name
---@param mode string 'fg' or 'bg'
local function match_color_to_highlight(base_color, ref_highlight, new_highlight_name, mode)
  local src_hl_data = vim.api.nvim_get_hl_by_name(ref_highlight, true)
	-- print('in: '..ref_highlight)
	-- P(src_hl_data)
  local new_hi_data = {}
  for k, v in pairs(src_hl_data) do
		if type(k) == "string"  then -- ignore eg. "boolean" keys
			new_hi_data[k] = v
			if (mode~=nil and mode==k) then
				if type(v) == "number" then
					local old_col = Color.from_hex(hex(v))

					local reference_hsl = old_col:to_hsl()
					local base_c = Color.from_hex(base_color)
					local base_hsl = base_c:to_hsl()
					local new_color = Color.from_hsl(base_hsl.hue, base_hsl.saturation, reference_hsl.lightness)
					new_hi_data[k] = new_color:to_hex()
				end
			end
		end
  end
	-- print(new_highlight_name)
	-- P(new_hi_data)
  write_highlight(new_highlight_name, new_hi_data)
end

local short_key = {foreground= 'fg', background = 'bg'}
local long_key = {fg = 'foreground', bg = 'background'}


---opts eg {bg=-4}    - reduce contrast by 4
local function adjust_col_contrast(old_col, factor)
	local old_col = Color.from_hex(hex(old_col))
	local old_hsv = old_col:to_hsv()
	local new_color
	if old_hsv.value > 50 then
		new_color = old_col:brighten(factor)
	else
		new_color = old_col:brighten(-factor)
	end
  return new_color
end


---Match base_color lightness to reference highlight, and create new highlight from it
---@param base_color string hex color
---@param ref_highlight string highlight name
---@param new_highlight_name string new highlight name
---@param mode string 'fg' or 'bg'
local function match_hl_to_highlight(highlight_name, ref_highlight, opts)
	-- print(highlight_name)
  local hl_data = vim.api.nvim_get_hl_by_name(highlight_name, true)
	-- vim.pretty_print(hl_data)
	-- print('from: '..ref_highlight)
	local ref_hl_data = vim.api.nvim_get_hl_by_name(ref_highlight, true)
	-- vim.pretty_print(ref_hl_data)
  for k, v in pairs(ref_hl_data) do -- k can be 'foreground' or 'background' etc.
		if type(k) == "boolean"  then -- ignore eg. "boolean" keys
			hl_data[k] = nil
		end
    if opts[short_key[k]] ~= nil then -- user set background = -5 contranst?
			local new_color = adjust_col_contrast(v, opts[short_key[k]])
      hl_data[k] = new_color:to_hex()
    end
  end
	-- adjust hl itself,  if opts.fg or opts.bg in hl
	-- for k,_ in pairs(opts) do  -- opts can be 'fg' or 'bg' etc.
	-- 	if hl_data[long_key[k]] ~= nil then
	-- 		local new_color = adjust_col_contrast(hl_data[long_key[k]], opts[k])
	-- 		hl_data[k] = new_color:to_hex()
	-- 	end
	-- end
	-- vim.pretty_print(old_hl_data)
  write_highlight(highlight_name, hl_data)
end


--- Adjust highlight color and return it as new highlight
---@param new_highlight_name string new highlight name
---@param src_highlight string source highlight name
---@param opts table options
---      @ fg, bg - factor
---			 @ reduct contrast for fg, or bg  by factor
local function highlight_from_src(new_highlight_name, src_highlight, opts)
  -- local factor = opts.factor == nil and opts.factor or -5

  -- local src_hl_data = get_color_from_hl(src_highlight)
  local src_hl_data = vim.api.nvim_get_hl_by_name(src_highlight, true)
	-- print('in: '..ref_highlight)
	-- P(src_hl_data)
  local new_hi_data = {}
	-- print("src_highlight: "..src_highlight)
	-- print("new_highlight_name: "..new_highlight_name)
  for k, v in pairs(src_hl_data) do
    -- if type(v) == "number" then
		-- print(tostring(k)..tostring(opts[short_key[k]]))
		new_hi_data[k] = v
    if opts[short_key[k]] ~= nil then -- user set background = -5 contranst?
			local new_color = adjust_col_contrast(v, opts[short_key[k]])
      new_hi_data[k] = new_color:to_hex()
    -- elseif type(v) == "boolean" then -- eg style ?
    --   new_hi_data[k] = v
    end
  end
  write_highlight(new_highlight_name, new_hi_data)
end

local theme_change_au = vim.api.nvim_create_augroup("MyThemeChangeAu", { clear = true })

local function match_color_to_highlight_au(base_color, ref_highlight, new_highlight_name, mode)
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			match_color_to_highlight(base_color, ref_highlight, new_highlight_name, mode)
		end,
		group = theme_change_au,
	})
end

local function match_hl_to_highlight_au(new_highlight_name, ref_highlight, opts)
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			match_hl_to_highlight(new_highlight_name, ref_highlight, opts)
		end,
		group = theme_change_au,
	})
end

local function highlight_from_src_au(new_highlight_name, src_highlight, opts)
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			highlight_from_src(new_highlight_name, src_highlight, opts) -- reduce contrast by default by -5
		end,
		group = theme_change_au,
	})
end
local function highlight_link_au(from_highlight, to_highlight)
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		command = 'highlight! link '..from_highlight..' '..to_highlight,
		group = theme_change_au,
	})
end


M.highlight_link = highlight_link_au -- link without adjusting color
M.match_hl_to_highlight = match_hl_to_highlight_au -- link without adjusting color
M.highlight_from_src = highlight_from_src_au
M.match_color_to_highlight = match_color_to_highlight_au
return M
