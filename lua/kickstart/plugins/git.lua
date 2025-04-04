return {
  'tpope/vim-rhubarb',
  {
    'tpope/vim-fugitive',
    init = function()
      vim.keymap.set('n', '<leader>gw',
        function()
          if vim.bo.filetype == 'fugitive' then
            vim.cmd('quit')
          else
            vim.cmd('G')
          end
        end, { desc = 'Toggle Git Fugitive Window' })
      vim.api.nvim_create_user_command('Gc', function(args)
        local vimCmd = 'Git commit -m'
        if args['args'] then
          vimCmd = vimCmd .. ' ' .. args['args']
        end
        vim.cmd(vimCmd)
      end, { desc = 'Commit with a message', nargs = '*' })

      vim.api.nvim_create_user_command('Gp', function(args)
        local vimCmd = 'Git push'
        if args['args'] then
          vimCmd = vimCmd .. ' ' .. args['args']
        end
        vim.cmd(vimCmd)
      end, { desc = 'Git push', nargs = '*' })
    end
  },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" }
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n' }, ']h', function()
          if vim.wo.diff then
            vim.cmd.normal { ']h', bang = true }
          else
            gs.nav_hunk('next')
          end
        end, { desc = 'Jump to next hunk' })

        map({ 'n' }, '[h', function()
          if vim.wo.diff then
            vim.cmd.normal { '[h', bang = true }
          else
            gs.nav_hunk('prev')
          end
        end, { desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })

        -- normal mode
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage/Unstage Hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk_inline, { desc = 'Preview Hunk Inline' })
        map('n', '<leader>hP', gs.preview_hunk, { desc = 'Preview Hunk' })

        map('n', '<leader>ga', function()
          gs.blame_line { full = false }
        end, { desc = 'Git Blame' })
        map('n', '<leader>gd', gs.diffthis, { desc = 'git diff against index' })
        -- Toggles
        map('n', '<leader>gA', gs.toggle_current_line_blame, { desc = 'Toggle Line Blame' })
      end,
    },
  },

}
