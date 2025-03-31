vim.loader.enable()
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- [[ Configure plugins ]]
require('lazy').setup({

  require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.avante',
  require 'kickstart.plugins.ui',
  require 'kickstart.plugins.completion',
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.git',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.lsp',
  require 'kickstart.plugins.snacks',
  require 'kickstart.plugins.test',
  require 'kickstart.plugins.treesitter',

  { import = 'custom.plugins' },
}, {
  rocks = { enabled = false },
  ui = {
    -- define a unicode icons table
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- [[ Custom Modules ]]
require 'options'
require 'keymaps'
require 'commands'
require 'snippets'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
