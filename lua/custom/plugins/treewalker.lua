return {
    'aaronik/treewalker.nvim',
    cmd = 'Treewalker',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    keys = {
        { '{',     '<cmd>Treewalker Up<cr>',        mode = { 'n', 'v' }, silent = true },
        { '}',     '<cmd>Treewalker Down<cr>',      mode = { 'n', 'v' }, silent = true },
        { ']g',    '<cmd>Treewalker Right<cr>',     mode = { 'n', 'v' }, silent = true, desc = 'Go Right with Treewalker' },
        { '[g',    '<cmd>Treewalker Left<cr>',      mode = { 'n', 'v' }, silent = true, desc = 'Go Left with Treewalker' },

        { '<M-{>', '<cmd>Treewalker SwapUp<cr>',    mode = 'n',          silent = true },
        { '<M-}>', '<cmd>Treewalker SwapDown<cr>',  mode = 'n',          silent = true },
        { '<M-]>', '<cmd>Treewalker SwapRight<CR>', mode = 'n',          silent = true },
        { '<M-[>', '<cmd>Treewalker SwapLeft<CR>',  mode = 'n',          silent = true },
    }
}
