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
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["compe-tabnine"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/compe-tabnine"
  },
  ["ctrlsf.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/ctrlsf.vim"
  },
  ["far.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/far.vim"
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
  nerdtree = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nerdtree"
  },
  ["nerdtree-git-plugin"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nerdtree-git-plugin"
  },
  ["numb.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/numb.nvim"
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
  ["vim-localhistory"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-localhistory"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-peekaboo"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-peekaboo"
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
  vimspector = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vimspector"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
