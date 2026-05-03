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
                '<leader>cT',
                function()
                    local cmd = vim.fn.input(':', 'GoTagAdd ')
                    if cmd ~= '' then
                        vim.cmd(cmd)
                    end
                end,
                desc = 'Add Custom Tags to struct',
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
            {
                '<leader>cj',
                function() vim.cmd.GoJson() end,
                desc = "Convert JSON to struct",
                ft = 'go',
            }
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
        init = function()
            vim.api.nvim_create_autocmd({ 'BufRead', 'BufEnter' }, {
                group = vim.api.nvim_create_augroup('godoc_treesitter', { clear = true }),
                pattern = '*.go',
                callback = function()
                    vim.treesitter.language.register('go', 'godoc')
                end,
            })
        end,
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
        "samiulsami/cmp-go-deep",
        ft = "go",
        dependencies = "kkharji/sqlite.lua",
    },

}
