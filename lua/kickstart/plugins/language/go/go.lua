return {
    {
        'olexsmir/gopher.nvim',
        ft = 'go',
        cmd = 'GoInstallDeps',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        build = ':GoInstallDeps',
        opts = {},
        keys = {
            {
                '<leader>ct',
                function() require("gopher").tags.add "json" end,
                desc = 'Add JSON Tags to struct',
                ft = 'go'
            },
            {
                '<leader>cc',
                function() vim.cmd.GoCmt() end,
                desc = 'Generate boilerplate for doc comments',
                ft = 'go'
            },
        },
    },
    {
        'fredrikaverpil/godoc.nvim',
        version = '*',
        dependencies = { 'folke/snacks.nvim', 'nvim-treesitter/nvim-treesitter' },
        build = 'go install github.com/lotusirous/gostdsym/stdsym@latest',
        cmd = 'GoDoc',
        opts = {
            picker = { type = 'snacks' },
            window = { type = 'vsplit' },
        },
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
