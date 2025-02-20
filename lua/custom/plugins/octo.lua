return {
    'pwntester/octo.nvim',
    enabled = vim.fn.executable 'gh' == 1,
    dependencies = {
        'folke/snacks.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {}
}
