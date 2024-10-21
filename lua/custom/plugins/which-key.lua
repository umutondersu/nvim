return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    dependencies = { 'echasnovski/mini.icons', 'nvim-tree/nvim-web-devicons', },
    opts = {
        preset = "modern",
        spec = {
            { "<leader>c",  group = "[C]opilot Chat", mode = { 'n', 'v' } },
            { "<leader>f",  group = "Format",         mode = { 'n', 'v' } },
            { "<leader>g",  group = "Git" },
            { "<leader>h",  group = "Git [H]unk",     mode = { 'n', 'v' } },
            { "<leader>n",  group = "[N]o Neck Pain" },
            { "<leader>r",  group = "Rename",         mode = { 'n', 'v' } },
            { "<leader>s",  group = "Search" },
            { "<leader>sn", group = "Search [N]eovim" },
            { "<leader>t",  group = "Test" },
            { "gp",         group = "[P]review" },
        },
    },
    config = function(_, opts)
        -- For nvim-surround to work with which-key TODO: Remove when/if the bug is fixed
        vim.o.timeout = false
        require("which-key").setup(opts)
    end,
}
