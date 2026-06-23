require 'core.options' -- load options
require 'core.keymaps' -- load general keymaps

-- pckg manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- file directory
vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- plugins
require('lazy').setup({
  -- require(themes[env_var_nvim_theme]),
  --  require 'plugins.telescope',
  --  require 'plugins.nvim-tree',
  --  require 'plugins.treesitter',
  --  require 'plugins.autocompletion',
  --  require 'plugins.lualine',
   -- require 'plugins.bufferline',
  -- require 'plugins.neo-tree',
   -- require 'plugins.alpha',
   -- require 'plugins.indent-blankline',
   -- require 'plugins.lazygit',
   -- require 'plugins.comment',
   -- require 'plugins.debug',
   -- require 'plugins.gitsigns',
   -- require 'plugins.harpoon',
   -- require 'plugins.aerial',
   -- require 'plugins.lsp',
   require 'plugins.which-key',
   require 'plugins.themify',
   require 'plugins.lualine',
   require 'plugins.flash',
   require 'plugins.bufferline',
   require 'plugins.neo-tree',
   require 'plugins.lsp',
   require 'plugins.treesitter',
   require 'plugins.nvim-surround',
   require 'plugins.harpoon',
   require 'plugins.code-action',
   require 'plugins.fff',
   require 'plugins.snacks',
})

-- restore session
local function file_exists(file)
  local f = io.open(file, 'r')
  if f then
    f:close()
    return true
  else
    return false
  end
end

local session_file = '.session.vim'

if file_exists(session_file) then
  vim.cmd('source ' .. session_file)
end