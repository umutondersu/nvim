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
        keys = {
            {
                '<leader>ct',
                function() require("gopher").tags.add "json" end,
                desc = 'LSP: Add JSON Tags to struct',
                ft = 'go'
            },
            {
                '<leader>cc',
                function() vim.cmd.GoCmt() end,
                desc = 'LSP: Generate boilerplate for doc comments',
                ft = 'go'
            },
        },
    },
    {
        'fredrikaverpil/godoc.nvim',
        ft = 'go',
        version = '*',
        dependencies = { 'folke/snacks.nvim' },
        build = 'go install github.com/lotusirous/gostdsym/stdsym@latest',
        cmd = { 'GoDoc' },
        opts = { picker = { type = 'snacks' } },
        keys = {
            {
                '<leader>so',
                function() vim.cmd.GoDoc() end,
                desc = 'Go Docs',
                ft = 'go'

            },
        }
    },
    {
        "maxandron/goplements.nvim",
        ft = "go",
        opts = {},
        keys = {
            {
                '<leader>cp',
                function() require("goplements").toggle() end,
                desc = 'Toggle Goplements',
                ft = 'go'
            },
        }
    }
}
