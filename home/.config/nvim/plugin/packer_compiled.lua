-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/jackson/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/jackson/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/jackson/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/jackson/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/jackson/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/barbar.nvim"
  },
  ["bclose.vim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/bclose.vim"
  },
  ["bracey.vim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/bracey.vim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  ["feline.nvim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/feline.nvim"
  },
  firenvim = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/firenvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/goyo.vim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/lazygit.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  neoformat = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-comment"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/nvim-comment"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  nvim_utils = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/nvim_utils"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["python-snippets"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/python-snippets"
  },
  rainbow = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/rainbow"
  },
  ["ranger.vim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/ranger.vim"
  },
  ["suda.vim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/suda.vim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/vim-easymotion"
  },
  ["vim-fish"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/vim-fish"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/vim-floaterm"
  },
  ["vim-prettier"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/vim-prettier"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/vim-toml"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ"
  },
  ["vscode-javascript"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/vscode-javascript"
  },
  ["vscode-python-snippet-pack"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/vscode-python-snippet-pack"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/home/jackson/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
