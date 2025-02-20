return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    dependencies = { 'echasnovski/mini.icons', 'nvim-tree/nvim-web-devicons', },
    opts = {
        preset = "modern",
        delay = 0,
        spec = {
            { "<leader>f",  group = "Format",          mode = { 'n', 'v' } },
            { "<leader>g",  group = "Git" },
            { "<leader>h",  group = "Git Hunk",        mode = { 'n', 'v' } },
            { "<leader>r",  group = "Rename",          mode = { 'n', 'v' } },
            { "<leader>s",  group = "Search",          mode = { 'n', 'v' } },
            { "<leader>sn", group = "Search Neovim" },
            { "<leader>t",  group = "Test" },
            { "gp",         group = "Preview" },
            { "<leader>a",  group = "Avante",          mode = { 'n', 'v' } },
            { "<leader>ap", group = "avante: prompts", mode = { 'n', 'v' } },
            { "<leader>u",  group = "Ui" },
            { "<leader>S",  group = "Scratch" },
            { "<leader>c",  group = "Code" },
        },
    },
}
