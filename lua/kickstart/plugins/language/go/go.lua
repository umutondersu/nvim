return {
    {
        'olexsmir/gopher.nvim',
        ft = 'go',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        build = function()
            if vim.bo.filetype == 'go' then
                vim.cmd.GoInstallDeps()
            else
                vim.notify('Gopher.nvim could not install dependencies, Try running GoInstallDeps in a go file',
                    vim.log.levels.WARN)
            end
        end,
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
