local M = {}

P = function(v)
  print(vim.inspect(v))
  return v
end

local Color = require "nightfox.lib.color"

local fmt = string.format

local function get_color_from_hl(name)
  local result = {}
  for k, v in pairs(vim.api.nvim_get_hl_by_name(name, true)) do
    if type(v) == "number" then
      result[k] = fmt("#%06x", v)
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

local function write_highlight(name, color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local sp = color.sp and "guisp=" .. color.sp or ""
  local hl = "highlight " .. name .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp
  -- print(hl)
  vim.cmd(hl)
end

---Match base_color lightness to reference highlight, and create new highlight from it
---@param base_color string hex color
---@param ref_highlight string highlight name
---@param new_highlight string new highlight name
---@param mode string 'fg' or 'bg'
local function match_color_to_highlight(base_color, ref_highlight, new_highlight, mode)
  mode = mode and mode or "bg"

  local src_hl_col = get_color_from_hl(ref_highlight)

  local old_col
  if mode == "bg" then
    old_col = src_hl_col.background
  else
    old_col = src_hl_col.foreground
  end

  if old_col == nil then
    write_highlight(new_highlight, { [mode] = base_color })
    return
  end

  old_col = Color.from_hex(old_col)
  local reference_hsl = old_col:to_hsl()
  local base_c = Color.from_hex(base_color)
  local base_hsl = base_c:to_hsl()
  -- print('base v '..base_hsl.lightness)
  -- print('new v '..reference_hsl.lightness)
  local new_color = Color.from_hsl(base_hsl.hue, base_hsl.saturation, reference_hsl.lightness)

  write_highlight(new_highlight, { [mode] = new_color:to_css() })
end

--- Adjust highlight color and return it as new highlight
---@param new_highlight string new highlight name
---@param src_highlight string source highlight name
---@param opts table options
---      @action string 'contrast' or 'brighten' default 'contrast'
---      @gui_mode string 'bg' or 'fg' default 'bg'
---			 @factor number (-100, 100) default -5 (reduce contrast)
local function highlight_adjust_col(new_highlight, src_highlight, opts)
  local action = opts.action and opts.action or "contrast"
  local gui_mode = opts.gui_mode and opts.gui_mode or "bg"
  local factor = opts.factor and opts.factor or -5

  local src_hl_col = get_color_from_hl(src_highlight)

  local old_col
  if gui_mode == "bg" then
    old_col = src_hl_col.background
  else
    old_col = src_hl_col.foreground
  end

  if old_col == nil then
    -- print("Cant update highlight " .. src_highlight)
    return
  end

  old_col = Color.from_hex(old_col)
  local old_hsv = old_col:to_hsv()
  local new_color
  -- print('src hl '..src_highlight)
  -- print('target hl '..new_highlight)
  -- print("Action " .. action)
  -- print("gui_mode " .. gui_mode)
  -- print("factor " .. factor)
  -- P(old_col)
  if action == "contrast" then
    if old_hsv.value > 50 then
      new_color = old_col:brighten(factor)
      -- new_color = Color.from_hsv(old_hsv.hue, old_hsv.saturation, old_hsv.value + boost)
    else
      new_color = old_col:brighten(-factor)
    end
  elseif action == "brighten" then
    new_color = old_col:brighten(factor)
  end

  -- P(new_color:to_hsv())
  write_highlight(new_highlight, { [gui_mode] = new_color:to_css() })
end

M.highlight_adjust_col = highlight_adjust_col
M.match_color_to_highlight = match_color_to_highlight
return M
