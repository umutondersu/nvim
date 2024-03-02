return {
    'Wansmer/treesj',
    keys = {
        {
            "<leader>fs",
            function() vim.cmd "TSJToggle" end,
            mode = "n",
            desc = "Join or Split Code Block",
        },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {},
}
