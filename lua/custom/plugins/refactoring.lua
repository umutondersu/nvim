return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    keys = {
        { "<leader>re", function() return require('refactoring').refactor('Extract Variable') end, mode = { "n", "x" }, expr = true, desc = "Extract repeated expression to variable" },
        { "<leader>rE", function() return require('refactoring').refactor('Extract Function') end, mode = { "n", "x" }, expr = true, desc = "Extract Visual to function" },
        { "<leader>ri", function() return require('refactoring').refactor('Inline Variable') end,  mode = { "n", "x" }, expr = true, desc = "Inline variable with its value" },
        { "<leader>rI", function() return require('refactoring').refactor('Inline Function') end,  mode = { "n", "x" }, expr = true, desc = "Inline function call with its content" },
        { "<leader>rb", function() return require('refactoring').refactor('Extract Block') end,    mode = { "n", "x" }, expr = true, desc = "Extract Visual to block" },
    },
}
