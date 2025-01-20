return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    dependencies = { 'echasnovski/mini.icons', 'nvim-tree/nvim-web-devicons', },
    opts = {
        preset = "modern",
        spec = {
            { "<leader>f",  group = "Format",           mode = { 'n', 'v' } },
            { "<leader>g",  group = "Git" },
            { "<leader>h",  group = "Git Hunk",         mode = { 'n', 'v' } },
            { "<leader>r",  group = "Rename",           mode = { 'n', 'v' } },
            { "<leader>s",  group = "Search" },
            { "<leader>sn", group = "[S]earch [N]eovim" },
            { "<leader>t",  group = "Test" },
            { "gp",         group = "Preview" },
            { "<leader>a",  group = "Avante",           mode = { 'n', 'v' } },
            { "<leader>u",  group = "User" },
            { "<leader>n",  group = "Notification" },
            { "<leader>S",  group = "Scratch" },
        },
        delay = 0,
    },
    config = function(_, opts)
        -- For nvim-surround to work with which-key TODO: Remove when/if the bug is fixed
        vim.o.timeout = false
        require("which-key").setup(opts)
    end,
}
