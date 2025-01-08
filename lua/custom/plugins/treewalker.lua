return {
    'aaronik/treewalker.nvim',
    keys = {
        { '{',     '<cmd>Treewalker Up<cr>',        mode = { 'n', 'v' }, silent = true },
        { '}',     '<cmd>Treewalker Down<cr>',      mode = { 'n', 'v' }, silent = true },
        { '[g',    '<cmd>Treewalker Right<cr>',     mode = { 'n', 'v' }, silent = true, desc = 'Go Treewalker Right' },
        { ']g',    '<cmd>Treewalker Left<cr>',      mode = { 'n', 'v' }, silent = true, desc = 'Go Treewalker Left' },

        { '<C-{>', '<cmd>Treewalker SwapDown<cr>',  mode = 'n',          silent = true },
        { '<C-}>', '<cmd>Treewalker SwapUp<cr>',    mode = 'n',          silent = true },
        { '<C-]>', '<cmd>Treewalker SwapRight<CR>', mode = 'n',          silent = true },
        { '<C-[>', '<cmd>Treewalker SwapLeft<CR>',  mode = 'n',          silent = true },
    }
}
