local ft = { 'go' }
return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Adapters
        "nvim-neotest/neotest-go",
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
        { "<leader>tr",  function() require("neotest").run.run() end,                        desc = "Run the Nearest test",                                       ft = ft },
        { "<leader>tf",  function() require("neotest").run.run(vim.fn.expand("%")) end,      desc = "Run the current File",                                       ft = ft },
        { "<leader>td",  function() require("neotest").run.run(vim.fn.getcwd()) end,         desc = "Run all tests in the current Directory",                     ft = ft },
        { "<leader>tO",  function() require("neotest").output_panel.toggle() end,            desc = "Toggle Output Panel",                                        ft = ft },
        { "<leader>ts",  function() require("neotest").summary.toggle() end,                 desc = "Toggle Summary",                                             ft = ft },
        { "<leader>tw",  function() require("neotest").watch.toggle() end,                   desc = "Toggle Watch",                                               ft = ft },
        { "<leader>tW",  function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch on file",                                       ft = ft },
        { "]t",          function() require("neotest").jump.next({ status = 'failed' }) end, desc = "Failed Test Forward",                                        ft = ft },
        { "[t",          function() require("neotest").jump.prev({ status = 'failed' }) end, desc = "Failed Test Backward",                                       ft = ft },
        { "]T",          function() require("neotest").jump.prev({ status = 'failed' }) end, desc = "Failed Test Backward",                                       ft = ft },
        { "[T",          function() require("neotest").jump.next({ status = 'failed' }) end, desc = "Failed Test Forward",                                        ft = ft },
        -- Gopher mappings
        { "<leader>tg",  "",                                                                 desc = "+Generate Tests",                                            ft = 'go' },
        { "<leader>tga", "<cmd>GoTestAdd<cr>",                                               desc = "Generate a test for the function under cursor",              ft = 'go' },
        { "<leader>tgA", "<cmd>GoTestsAll<cr>",                                              desc = "Generate tests for the functions in the file",               ft = 'go' },
        { "<leader>tgE", "<cmd>GoTestsExp<cr>",                                              desc = "Generate tests for only the exported functions in the file", ft = 'go' },
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
