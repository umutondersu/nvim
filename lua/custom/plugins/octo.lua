return {
    'pwntester/octo.nvim',
    enabled = vim.fn.executable 'gh' == 1,
    dependencies = {
        {
            'nvim-telescope/telescope.nvim',
            dependencies = 'nvim-lua/plenary.nvim',
        },
        'nvim-tree/nvim-web-devicons',
    },
    opts = {},
}
