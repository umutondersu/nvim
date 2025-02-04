return {
  -- Git related plugins
  {
    'tpope/vim-fugitive',
    config = function() vim.keymap.set('n', '<leader>gw', '<cmd>G<cr>', { desc = 'Git Fugitive Window' }) end
  },
  { 'tpope/vim-rhubarb' },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
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
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage/unstage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk_inline, { desc = 'preview git hunk inline' })
        map('n', '<leader>hP', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>hD', function()
          gs.diffthis '@'
        end, { desc = 'git diff against last commit' })

        -- Toggles
        map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = 'toggle git show blame line' })
        map('n', '<leader>ht', gs.preview_hunk_inline, { desc = 'toggle git show deleted' })
      end,
    },
  },

}
