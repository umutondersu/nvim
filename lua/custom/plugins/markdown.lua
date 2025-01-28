return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown', 'avante' },
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
        opts = { file_types = { 'markdown', 'avante' } },
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
