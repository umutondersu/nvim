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
        require('mini.ai').setup { n_lines = 500, mappings = { around_last = 'ap', inside_last = 'ip' }, }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - siw) - [S]urround [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sc)'  - [S]urround [C]hange [)] [']
        require('mini.surround').setup({
            mappings = {
                add = 's',             -- Add surrounding in Normal and Visual modes
                delete = 'sd',         -- Delete surrounding
                find = 'sf',           -- Find surrounding (to the right)
                find_left = 'sF',      -- Find surrounding (to the left)
                highlight = 'sh',      -- Highlight surrounding
                replace = 'sc',        -- Replace surrounding
                update_n_lines = 'sn', -- Update `n_lines`
                suffix_last = 'l',     -- Suffix to search with "prev" method
                suffix_next = 'n',     -- Suffix to search with "next" method
            },
        })

        -- Extras
        require('mini.pairs').setup()
        require('mini.bracketed').setup()
        require('mini.icons').setup()
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
        require('mini.move').setup({
            mappings = {
                -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                left = 'H',
                right = 'L',
                down = 'J',
                up = 'K',
                -- Move current line in Normal mode
                line_left = '<M-h>',
                line_right = '<M-l>',
                line_down = '<M-j>',
                line_up = '<M-k>',
            },
        })
        vim.keymap.set('n', '<leader>e', function() MiniFiles.open() end, { desc = 'Open File Navigation' })
        require('mini.splitjoin').setup({
            mappings = {
                toggle = '<leader>fs',
                split = '',
                join = '',
            }
        })
        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini.nvim
    end,
}
