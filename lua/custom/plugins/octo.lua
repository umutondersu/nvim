return {
    'pwntester/octo.nvim',
    dependencies = {
        {
            'nvim-telescope/telescope.nvim',
            lazy = true,
            dependencies = 'nvim-lua/plenary.nvim',
        },
        'nvim-tree/nvim-web-devicons',
    },
    opts = {},
}
