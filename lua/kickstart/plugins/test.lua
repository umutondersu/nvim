local ft = { 'go' }
return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Adapters
        { "nvim-contrib/neotest-ginkgo" },
        {
            "fredrikaverpil/neotest-golang",
            version = "*", -- Optional, but recommended; track releases
            ft = "go",
            cond = vim.fn.executable 'go' == 1,
            build = function()
                vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
            end,
        },
    },
    keys = {
        {
            "<leader>tO",
            function()
                require("neotest").output.open({ auto_close = true })
            end,
            desc = "Show Test Output",
            ft = ft
        },
        { "<leader>tt", function() require("neotest").run.run() end,                        desc = "Run Nearest test",     ft = ft },
        { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,      desc = "Run  File",            ft = ft },
        { "<leader>td", function() require("neotest").run.run(vim.fn.getcwd()) end,         desc = "Run Directory",        ft = ft },
        { "<leader>to", function() require("neotest").output_panel.toggle() end,            desc = "Toggle Output Panel",  ft = ft },
        { "<leader>ts", function() require("neotest").summary.toggle() end,                 desc = "Toggle Summary",       ft = ft },
        { "<leader>tw", function() require("neotest").watch.toggle() end,                   desc = "Toggle Watch",         ft = ft },
        { "<leader>tW", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch on file", ft = ft },
        { "]t",         function() require("neotest").jump.next({ status = 'failed' }) end, desc = "Failed Test Forward",  ft = ft },
        { "[t",         function() require("neotest").jump.prev({ status = 'failed' }) end, desc = "Failed Test Backward", ft = ft },
        { "]T",         function() require("neotest").jump.prev({ status = 'failed' }) end, desc = "Failed Test Backward", ft = ft },
        { "[T",         function() require("neotest").jump.next({ status = 'failed' }) end, desc = "Failed Test Forward",  ft = ft },
    },
    config = function()
        -- Wrap neotest-golang to exclude Ginkgo test files (those importing onsi/ginkgo)
        local golang_adapter = require("neotest-golang")({ runner = "gotestsum" })
        local original_is_test_file = golang_adapter.is_test_file
        golang_adapter.is_test_file = function(file_path)
            if not original_is_test_file(file_path) then return false end
            local f = io.open(file_path, "r")
            if f then
                local content = f:read(2048)
                f:close()
                if content:find('"github.com/onsi/ginkgo', 1, true) then
                    return false
                end
            end
            return true
        end

        require("neotest").setup({
            adapters = {
                require("neotest-ginkgo"),
                golang_adapter,
            },
        })
    end,
}
