return {
    {
        'olexsmir/gopher.nvim',
        ft = 'go',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        build = function() vim.cmd.GoInstallDeps() end,
        opts = {},
    },
    {
        'fredrikaverpil/godoc.nvim',
        ft = 'go',
        version = '*',
        dependencies = { 'folke/snacks.nvim' },
        build = 'go install github.com/lotusirous/gostdsym/stdsym@latest',
        cmd = { 'GoDoc' },
        opts = { picker = { type = 'snacks' } }
    }
}
