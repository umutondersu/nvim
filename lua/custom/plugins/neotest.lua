return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Adapters
        "nvim-neotest/neotest-go",
    },
    keys = {
        {
            "<leader>tn",
            function()
                require("neotest").run.run()
            end,
            mode = "n",
            desc = "Run the [N]earest test",
        },
        {
            "<leader>tf",
            function()
                require("neotest").run.run(vim.fn.expand("%"))
            end,
            mode = "n",
            desc = "Run the current [F]ile"
        },
        {
            "<leader>td",
            function()
                require('neotest').run.run(vim.fn.getcwd())
            end,
            mode = "n",
            desc = "Run all tests in the current [D]irectory",
        },
        { "<leader>ts", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[S]how Output" },
        { "<leader>to", function() require("neotest").output_panel.toggle() end,                            desc = "Toggle [O]utput Panel" },
        { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "Toggle [S]ummary" },
    },

    config = function()
        -- get neotest namespace (api call creates or returns namespace)
        local neotest_ns = vim.api.nvim_create_namespace("neotest")
        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    local message =
                        diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                    return message
                end,
            },
        }, neotest_ns)
        require("neotest").setup({
            -- your neotest config here
            adapters = {
                require("neotest-go"),
            },
        })
    end,
}
