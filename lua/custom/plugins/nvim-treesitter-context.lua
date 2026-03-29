return {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufWinEnter',
    opts = {},
    keys = {
        {
            'gG',
            function() require('treesitter-context').go_to_context(vim.v.count1) end,
            desc = 'Goto to context'
        }
    }
}
