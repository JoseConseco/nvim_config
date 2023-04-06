local gps = require "nvim-navic"

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
  greenYel = "#EBCB8B",
}

local function get_cwd()
  -- local full_dir = vim.fn.expand('%:p') -- full file path
  -- http://vimdoc.sourceforge.net/htmldoc/cmdline.html#filename-modifiers
  local project_dir = vim.fn.getcwd()
  -- local project_dir = vim.fn.expand("%:p:~") - abs file path with ~/ format
  -- local home_dir = os.getenv("HOME")
  -- local abs_file_path = vim.fn.expand("%:p") -- #str - length -- relative path to pdir (or absolute smtim)
  local rel_file_dir = vim.fn.expand "%:p:~:." -- #str - length -- relative path to pdir (or absolute smtim)

  -- project_dir = project_dir:gsub(home_dir, '~')
  -- project_dir = vim.fn.expand("%:p:h")
  -- project_dir = project_dir:gsub('(%w)[%w|%s|_]*','%1.')..'> '
  if #project_dir > 15 then
    local cut_idx = #project_dir - project_dir:reverse():find "/" + 1
    if cut_idx then
      project_dir = "[" .. project_dir:sub(cut_idx+1, -1) .. "] /" -- show only last 25 digits
    else
      project_dir = "[" .. project_dir:sub(-10, -1) .. "] /"
    end
  else
    project_dir = project_dir .. "]"
  end

  return project_dir .. rel_file_dir .. " "
end

local function get_buffer_index_relative()
  local buffers = {}

  for buffer = 1, vim.fn.bufnr "$" do
    local is_listed = vim.fn.buflisted(buffer) == 1
    if is_listed then
      table.insert(buffers, buffer)
    end
  end
  local buff_cnt = #buffers

  local current_buff = vim.api.nvim_get_current_buf()
  local current_buff_idx = 0

  for idx, buff in ipairs(buffers) do
    if buff == current_buff then
      current_buff_idx = idx
    end
  end
  -- for i = 1, buffers do
  -- 	if buffers[i] == current_buff then
  -- 		current_buff_idx = i
  -- 		break
  -- 	end
  -- end

  return tostring(current_buff_idx) .. "/" .. tostring(buff_cnt)
end

local function modified()
  if vim.bo.modified then
    return "[+]"
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return "[!]"
  end
  return "[-]"
end

local function file_name()
  local file = vim.fn.expand "%:t"
  -- local extension = vim.fn.expand "%:e"
  -- local icon = require "nvim-web-devicons".get_icon(file, extension)
  -- if icon == nil then
  -- 	icon = ""
  -- end
  -- return "[" ..icon .. " " .. file .. "]"
  return file .. " [" .. get_buffer_index_relative() .. "]"
end

local function get_hl_fg(section)
  return { fg = string.format("#%06x", vim.api.nvim_get_hl_by_name("String", true).foreground) }
end

local lsp = {
  -- Lsp server name .
  function()
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    local out_clients = {}
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.config.autostart then
        table.insert(out_clients, client.name)
        -- return client.name
      end
    end
    if #out_clients > 0 then
      return table.concat(out_clients, ", ")
    else
      return "LS Inactive"
    end
  end,
  icon = "LSP:",
  -- color = { fg = '#ffffff', gui = 'bold' },
}

local progress = {
  function()
    local current_line = vim.fn.line "."
    local total_lines = vim.fn.line "$"
    local chars = { "██", "▇▇", "▆▆", "▅▅", "▄▄", "▃▃", "▂▂", "▁▁", "__" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end,
  -- color = { fg = C.fg, bg = C.bg },
}
require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "❰" }, -- left = '❱'
    section_separators = { left = "", right = "" },
    always_divide_middle = true,
    disabled_filetypes = { -- Filetypes to disable lualine for.
      statusline = { "starter" }, -- only ignores the ft for statusline.
      winbar = { "starter" }, -- only ignores the ft for winbar.
    },
  },
  sections = {
    lualine_a = { { "mode", color = { gui = "bold" } } },
    lualine_b = {},
    lualine_c = {
      -- { "filetype", icon_only = true },
      -- get_cwd,
      -- {'filename', path=1},
      -- { gps.get_location, cond = gps.is_available, color = get_hl_fg },
      "%=",
      lsp,
    },
    lualine_x = {}, -- 'encoding'
    lualine_y = {
      { "diagnostics", sources = { "nvim_diagnostic" } },
    },
    lualine_z = {
      {'os.date("%I:%M", os.time())', separator=nil},
      -- progress,
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    -- lualine_c = { "filename" },
    -- lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {
    lualine_c = {
      -- { "filetype", icon_only = true },
      -- {"%m  [%t]", separator=" ▶ "},
      -- {'filename', path=1, padding={right=0, left=5}, separator=" ▶ "},
      { modified, color = "WinBar" },
      { get_cwd, separator = " ▶ ", color = "WinBar" },
      -- { file_name, separator = " ▶ ", color = "WinBar" },
      { function() return gps.get_location() end, cond = gps.is_available, color = get_hl_fg },
    },
  },
  inactive_winbar = {
    lualine_c = {
      { modified, color = "WinBarNC" },
      { get_cwd, color = "WinBarNC" },
      -- { file_name, color = "WinBarNC" },
      { function() return gps.get_location() end, cond = gps.is_available, color = "WinBarNC" },
    },
  },
  extensions = {},
}
