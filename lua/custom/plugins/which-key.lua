-- Useful plugin to show you pending keybinds.
-- {
--   'folke/which-key.nvim',
--   event = 'VeryLazy',
--   dependencies = { 'echasnovski/mini.icons', 'nvim-tree/nvim-web-devicons', },
--   opts = {
--     preset = "modern",
--     spec = {
--       { "<leader>c",  group = "[C]opilot Chat",       mode = { 'n', 'v' } },
--       { "<leader>f",  group = "[F]ormat",       mode = { 'n', 'v' } },
--       { "<leader>g",  group = "[G]it" },
--       { "<leader>h",  group = "Git [H]unk",       mode = { 'n', 'v' } },
--       { "<leader>n",  group = "[N]o Neck Pain" },
--       { "<leader>r",  group = "[R]ename" ,       mode = { 'n', 'v' }},
--       { "<leader>s",  group = "[S]earch" },
--       { "<leader>sn", group = "[S]earch [N]eovim" },
--       { "<leader>t",  group = "[T]est" },
--       { "gp",         group = "[P]review" },
--     },
--   },
-- },
return {
    'folke/which-key.nvim',
    event = 'Vimenter',
    config = function()
        require("which-key").setup()
        require('which-key').register {
            ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
            ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore', mode = { 'n', 'v' } },
            ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore', mode = { 'n', 'v' } },
            ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
            ['<leader>sn'] = { name = '[S]earch [N]eovim', _ = 'which_key_ignore' },
            ['<leader>f'] = { name = '[F]ormat', _ = 'which_key_ignore', mode = { 'n', 'v' } },
            ['<leader>c'] = { name = '[C]opilot Chat', _ = 'which_key_ignore', mode = { 'n', 'v' } },
            ['<leader>n'] = { name = '[N]o Neck Pain', _ = 'which_key_ignore' },
            ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
            ['gp'] = { name = '[P]review', _ = 'which_key_ignore' },
        }
    end,
}
