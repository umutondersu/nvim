return {
    {
        "OXY2DEV/markview.nvim",
        ft = "markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        }
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        enabled = vim.fn.executable 'deno' == 1,
        config = function()
            local opts = {}
            if vim.fn.getenv("REMOTE_CONTAINERS") == 'true' then
                opts = { app = "browser" }
            end
            require("peek").setup(opts)
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    }
}
