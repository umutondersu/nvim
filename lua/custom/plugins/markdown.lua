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
        keys = {
            {
                '<C-x>',
                '<cmd>BufferVacuumPinBuffer<CR>',
                desc = 'Pin/Unpin Buffer',
            },
        }
    },
    {
        "toppair/peek.nvim",
        build = "deno task --quiet build:fast",
        enabled = vim.fn.executable 'deno' == 1,
        ft = 'markdown',
        config = function()
            require('peek').setup({ app = 'browser' })
            local function openPeek()
                require('peek').open()
                vim.notify("Peek opened! Check your browser window.", vim.log.levels.INFO)
            end
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    vim.api.nvim_buf_create_user_command(0, "PeekOpen", function()
                        openPeek()
                    end, {})

                    vim.api.nvim_buf_create_user_command(0, "PeekClose", function()
                        require('peek').close()
                    end, {})

                    vim.api.nvim_buf_create_user_command(0, "Peek", function()
                        if require('peek').is_open() then
                            require('peek').close()
                        else
                            openPeek()
                        end
                    end, {})
                end,
            })
        end,
    }
}
