return {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    config = function()
        vim.keymap.set('n', 'gC',
            function() require('treesitter-context').go_to_context(vim.v.count1) end,
            { desc = 'Jump to context' }
        )
    end,
}
