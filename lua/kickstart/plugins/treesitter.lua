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
  opts = {
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

    auto_install = true,

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
      move = {
        enable = true,
        goto_next_start = { [']f'] = '@function.outer' },
        goto_next_end = { [']F'] = '@function.outer' },
        goto_previous_start = { ['[f'] = '@function.outer' },
        goto_previous_end = { ['[F'] = '@function.outer' },
      },
    },

  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    { 'windwp/nvim-ts-autotag', opts = {} },
    {
      'nvim-treesitter/nvim-treesitter-context',
      keys = {
        {
          'gC',
          function() require('treesitter-context').go_to_context(vim.v.count1) end,
          mode = 'n',
          desc = 'Jump to context',
        },
      },
    }
  },
}
