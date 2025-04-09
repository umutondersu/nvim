return {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    keys = {
        {
            'gC',
            function() require('treesitter-context').go_to_context(vim.v.count1) end,
            mode = 'n',
            desc = 'Jump to context',
        },
    },
}
