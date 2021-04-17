" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/bartosz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/bartosz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/bartosz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/bartosz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/bartosz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["FTerm.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nFTerm\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/FTerm.nvim"
  },
  ["ayu-vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/ayu-vim"
  },
  ["clever-f.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/clever-f.vim"
  },
  ["codi.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/codi.vim"
  },
  ["compe-tabnine"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/compe-tabnine"
  },
  ["ctrlsf.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/ctrlsf.vim"
  },
  edge = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/edge"
  },
  ["far.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/far.vim"
  },
  ["fern-git-status.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/fern-git-status.vim"
  },
  ["fern.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/fern.vim"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/hop.nvim"
  },
  indentLine = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/indentLine"
  },
  ["lens.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/lens.vim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["minimap.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/minimap.vim"
  },
  neoformat = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  ["numb.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/numb.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-bqf"
  },
  ["nvim-bufferline.lua"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-comment"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-comment"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-luapad"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-luapad"
  },
  ["nvim-spectre"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-spectre"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["nvim-whichkey-setup.lua"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-whichkey-setup.lua"
  },
  ["oceanic-next"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/oceanic-next"
  },
  ["onedark.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/onedark.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["registers.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/registers.nvim"
  },
  ["scrollbar.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/scrollbar.nvim"
  },
  tabular = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/tabular"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  undotree = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-case-change"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-case-change"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-grepper"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-grepper"
  },
  ["vim-lion"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-lion"
  },
  ["vim-localhistory"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-localhistory"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-smoothie"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-which-key"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-which-key"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-wordmotion"
  },
  ["vim-yankstack"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-yankstack"
  },
  vimspector = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vimspector"
  }
}

-- Config for: FTerm.nvim
try_loadstring("\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nFTerm\frequire\0", "config", "FTerm.nvim")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
