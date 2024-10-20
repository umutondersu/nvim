return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  config = function()
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        mappings = {
          n = {
            ['q'] = require('telescope.actions').close,
            ['d'] = require('telescope.actions').delete_buffer,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'aerial')

    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader><space>',
      function()
        require('telescope.builtin').buffers {
          initial_mode = 'normal',
          sort_mru = true,
          sort_lastused = true,
        }
      end,
      { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    local function telescope_live_grep_open_files()
      require('telescope.builtin').live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end
    vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
    vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sG', require('telescope.builtin').git_files, { desc = '[S]earch [F]iles [G]it' })
    vim.keymap.set('n', '<leader>sf', function() require('telescope.builtin').find_files({ no_ignore = true }) end,
      { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<cr>', { desc = '[S]earch [T]odo Comments' })

    -- Telescope Shortcuts for Neovim Help
    vim.keymap.set('n', '<leader>snh', require('telescope.builtin').help_tags, { desc = '[S]earch [N]eovim [H]elp' })
    vim.keymap.set('n', '<leader>snk', require('telescope.builtin').keymaps, { desc = '[S]earch [N]eovim [K]eymaps' })
    vim.keymap.set('n', '<leader>snf', function()
      require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim [F]iles' })

    -- Telescope Shortcuts for Git commands
    vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = '[G]it [S]tatus' })
    vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = '[G]it [C]ommits' })
    vim.keymap.set('n', '<leader>gB', require('telescope.builtin').git_branches, { desc = '[G]it [B]ranches' })
    vim.keymap.set('n', '<leader>gS', require('telescope.builtin').git_stash, { desc = '[G]it [S]tash' })
  end,
}
