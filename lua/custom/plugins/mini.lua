return { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    version = false,
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        require('mini.ai').setup { n_lines = 500, mappings = { around_last = 'ap', inside_last = 'ip', search_method = 'cover' } }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - gsaw)  - [G]enerously [S]urround [A]round [W]ord [)]Paren
        -- - gsd'   - [G]racefully [S]urround [D]elete [']quotes
        -- - gsc)'  - [G]loriously [S]urround [C]hange [)] [']
        require('mini.surround').setup({
            mappings = {
                add = 'gs',             -- Add surrounding in Normal and Visual modes
                delete = 'gsd',         -- Delete surrounding
                find = 'gsf',           -- Find surrounding (to the right)
                find_left = 'gsF',      -- Find surrounding (to the left)
                highlight = 'gsh',      -- Highlight surrounding
                replace = 'gsc',        -- Replace surrounding
                update_n_lines = 'gsn', -- Update `n_lines`

                suffix_last = 'p',      -- Suffix to search with "prev" method
                suffix_next = 'n',      -- Suffix to search with "next" method
            },
        })
        -- Move lines easily in visual and normal mode
        require('mini.move').setup({
            mappings = {
                -- Move visual selection in Visual mode
                left = 'H',
                right = 'L',
                down = 'J',
                up = 'K',
                -- Move current line in Normal mode
                line_left = '',
                line_right = '',
                line_down = '<M-j>',
                line_up = '<M-k>',
            },
        })

        require('mini.files').setup({
            mappings = {
                close       = 'q',
                go_in       = 'l',
                go_in_plus  = '<cr>',
                go_out      = 'h',
                go_out_plus = '<BS>',
                mark_goto   = '',
                mark_set    = '',
                reset       = 'r',
                reveal_cwd  = '@',
                show_help   = 'g?',
                synchronize = '<leader>w',
                trim_left   = '<',
                trim_right  = '>',
            },
        })
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'minifiles',
            callback = function()
                vim.keymap.set('n', '<leader>r', '^ct.', { desc = 'Change File Name w/o extension', buffer = true })
                vim.keymap.set('n', '<leader>x', 'V"+d', { desc = 'Cut File', buffer = true })
                vim.keymap.set('n', '<leader>y', 'Vy', { desc = 'Copy File', buffer = true })
                vim.keymap.set('n', '<leader>d', 'Vd', { desc = 'Delete File', buffer = true })
            end,
        })
        vim.keymap.set('n', '<M-e>', MiniFiles.open, { desc = 'File Navigation' })

        require('mini.pairs').setup()
        require('mini.bracketed').setup()
        require('mini.icons').setup()
        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini.nvim
    end,
}
