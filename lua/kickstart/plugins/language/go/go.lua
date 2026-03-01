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
                function() vim.cmd("GoTagAdd json") end,
                desc = 'Add JSON Tags to struct',
                ft = 'go'
            },
            {
                '<leader>cc',
                function() vim.cmd.GoCmt() end,
                desc = 'Generate boilerplate for doc comments',
                ft = 'go'
            },
            {
                "<leader>ta",
                function() require("gopher").test.add() end,
                desc = "Add test for the function under cursor",
                ft = 'go',
            },
            {
                "<leader>tA",
                function() require("gopher").test.exported() end,
                desc = "Add tests for exported functions",
                ft = 'go',
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
    },
    {
        "Yu-Leo/cmp-go-pkgs",
        ft = "go",
        init = function()
            vim.api.nvim_create_autocmd({ "LspAttach" }, {
                pattern = { "*.go" },
                callback = function(args)
                    require("cmp_go_pkgs").init_items(args)
                end,
            })
        end
    },
    {
        "samiulsami/cmp-go-deep",
        ft = "go",
        dependencies = "kkharji/sqlite.lua",
    },

}
