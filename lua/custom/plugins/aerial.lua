return {
    'stevearc/aerial.nvim',
    event = 'VeryLazy',
    opts = {
        on_attach = function(bufnr)
            vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
            vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
    },
    config = function(_, opts)
        require('aerial').setup(opts)
        local map = vim.keymap.set
        -- map('n', '<leader>o', '<cmd>AerialToggle<CR>', { desc = 'Toggle [O]utline' })
        map('n', '<leader>so', '<cmd>Telescope aerial<CR>', { desc = '[S]earch [O]utline' })
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
}
