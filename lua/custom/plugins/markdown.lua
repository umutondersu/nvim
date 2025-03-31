local ft = { 'markdown', 'avante', 'octo' }
return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = ft,
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
        opts = {
            file_types = ft,
            completions = { lsp = { enabled = true } }
        },
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        enabled = vim.fn.executable 'deno' == 1,
        opts = function()
            if vim.fn.getenv("REMOTE_CONTAINERS") == 'true' then
                return { app = "browser" }
            end
            return {}
        end,
        init = function()
            local peek = require('peek')
            vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
            vim.api.nvim_create_user_command("PeekClose", peek.close, {})
            vim.api.nvim_create_user_command("Peek", function()
                if peek.is_open() then
                    peek.close()
                    return
                end
                peek.open()
            end, {})
        end,
    }
}
