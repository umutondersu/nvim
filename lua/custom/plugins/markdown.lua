local ft = { 'markdown', 'octo' }
return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = ft,
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
        opts = {
            file_types = ft,
            completions = { lsp = { enabled = true } }
        },
    },
    {
        "toppair/peek.nvim",
        build = "deno task --quiet build:fast",
        enabled = vim.fn.executable 'deno' == 1,
        ft = 'markdown',
        config = function()
            require('peek').setup()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    vim.api.nvim_buf_create_user_command(0, "PeekOpen", function()
                        require('peek').open()
                    end, {})

                    vim.api.nvim_buf_create_user_command(0, "PeekClose", function()
                        require('peek').close()
                    end, {})

                    vim.api.nvim_buf_create_user_command(0, "Peek", function()
                        if require('peek').is_open() then
                            require('peek').close()
                        else
                            require('peek').open()
                        end
                    end, {})
                end,
            })
        end,
    }
}
