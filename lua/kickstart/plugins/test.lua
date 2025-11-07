local ft = { 'go' }
return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Adapters
        {
            "fredrikaverpil/neotest-golang",
            version = "*",                                                              -- Optional, but recommended; track releases
            build = function()
                vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
            end,
        },
    },
    keys = {
        {
            "<leader>to",
            function()
                require("neotest").output.open({ auto_close = true })
            end,
            desc = "Show Test Output",
            ft = ft
        },
        { "<leader>tr", function() require("neotest").run.run() end,                        desc = "Run the Nearest test",                   ft = ft },
        { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,      desc = "Run the current File",                   ft = ft },
        { "<leader>td", function() require("neotest").run.run(vim.fn.getcwd()) end,         desc = "Run all tests in the current Directory", ft = ft },
        { "<leader>tO", function() require("neotest").output_panel.toggle() end,            desc = "Toggle Output Panel",                    ft = ft },
        { "<leader>ts", function() require("neotest").summary.toggle() end,                 desc = "Toggle Summary",                         ft = ft },
        { "<leader>tw", function() require("neotest").watch.toggle() end,                   desc = "Toggle Watch",                           ft = ft },
        { "<leader>tW", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch on file",                   ft = ft },
        { "]t",         function() require("neotest").jump.next({ status = 'failed' }) end, desc = "Failed Test Forward",                    ft = ft },
        { "[t",         function() require("neotest").jump.prev({ status = 'failed' }) end, desc = "Failed Test Backward",                   ft = ft },
        { "]T",         function() require("neotest").jump.prev({ status = 'failed' }) end, desc = "Failed Test Backward",                   ft = ft },
        { "[T",         function() require("neotest").jump.next({ status = 'failed' }) end, desc = "Failed Test Forward",                    ft = ft },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-golang")({
                    runner = "gotestsum"
                }),
            },
        })
    end,
}
