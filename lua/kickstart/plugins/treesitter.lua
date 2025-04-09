return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  version = false,
  event = 'VeryLazy',
  build = ':TSUpdate',
  cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  keys = {
    { '<C-A-space>', desc = 'Increment Selection' },
    { '<bs>',        desc = 'Decrement Selection', mode = 'x' },
  },
  dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
  opts = {
    auto_install = true,
    ensure_installed = {
      'c',
      'cpp',
      'go',
      'lua',
      'python',
      'fish',
      'tsx',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'bash',
      'http',
      'json',
      'sql',
      'markdown',
      'markdown_inline', -- noice.nvim
      'regex',           -- noice.nvim
      'diff',
    },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-A-space>',
        node_incremental = '<C-A-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = { query = '@function.outer', desc = "around function", },
          ['if'] = { query = '@function.inner', desc = "inside function", },
        }
      },
      move = {
        enable = true,
        goto_next_start = { [']f'] = { query = '@function.outer', desc = 'Function forward' } },
        goto_next_end = { [']F'] = { query = '@function.outer', desc = 'Function backward' } },
        goto_previous_start = { ['[f'] = { query = '@function.outer', desc = 'Function backward' } },
        goto_previous_end = { ['[F'] = { query = '@function.outer', desc = 'Function forward' } },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end
}
