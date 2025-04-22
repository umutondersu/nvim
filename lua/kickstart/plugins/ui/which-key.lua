return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    dependencies = { 'echasnovski/mini.icons', 'nvim-tree/nvim-web-devicons', },
    opts = {
        preset = "modern",
        delay = 0,
        spec = {
            { "<leader>f",  group = "Format" },
            { "<leader>g",  group = "Git" },
            { "<leader>h",  group = "Git Hunk",        mode = { 'n', 'v' } },
            { "<leader>r",  group = "Refactor",        mode = { 'n', 'v' } },
            { "<leader>s",  group = "Search",          mode = { 'n', 'v' } },
            { "<leader>sn", group = "Search Neovim" },
            { "<leader>t",  group = "Test" },
            { "gp",         group = "Preview" },
            { "<leader>ap", group = "avante: prompts", mode = { 'n', 'v' } },
            { "<leader>u",  group = "Ui" },
            { "<leader>c",  group = "Code",            mode = { 'n', 'v' } },
            { "<leader>d",  group = "Debug" },
            {
                "<leader>S",
                group = "Scratch",
                icon = { icon = '󱓧', color = 'red' },
            },
            {
                "<leader>a",
                group = "Avante",
                mode = { 'n', 'v' },
                icon = { icon = '', color = 'yellow' },
            }
        },
    },
}
