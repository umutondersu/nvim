return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  opts = {
    -- Add languages to be installed here that you want installed for treesitter
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

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,

    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = { query = '@function.outer', desc = "around function", },
          ['if'] = { query = '@function.inner', desc = "inside function", },
          ['ac'] = { query = '@class.outer', desc = "around class", },
          ['ic'] = { query = '@class.inner', desc = "inside class", },
          ['ii'] = { query = '@conditional.inner', desc = "inside conditional", },
          ['ai'] = { query = '@conditional.outer', desc = "around conditional", },
          ['il'] = { query = '@loop.inner', desc = "inside loop", },
          ['al'] = { query = '@loop.outer', desc = "around loop", },
        },
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
          function() require("treesitter-context").go_to_context(vim.v.count1) end,
          mode = 'n',
          desc = 'Jump to context',
        },
      },
      config = function()
        vim.cmd('hi TreesitterContext guibg=none | hi TreesitterContextLineNumber guisp=Red')
      end,
    }
  },
}
