local leet_arg = 'leetcode.nvim'
return {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'nvim-lua/plenary.nvim', -- required by telescope
        'MunifTanjim/nui.nvim',

        -- optional
        'nvim-treesitter/nvim-treesitter',
        'rcarriga/nvim-notify',
        'nvim-tree/nvim-web-devicons',
    },
    lazy = leet_arg ~= vim.fn.argv()[1],
    opts = {
        arg = leet_arg,
        lang = 'python3',
        -- directory = os.getenv('HOME') .. '/leetcode',
    },
    keys = { {
        '<leader>l',
        function()
        end,
        desc = '+[L]eetcode',
        ft = { 'leetcode.nvim' }
    }, {
        '<leader>lc',
        '<cmd> Leet console<cr>',
        desc = 'open [C]onsole popup',
        ft = { 'leetcode.nvim' }
    }, {
        '<leader>li',
        '<cmd> Leet info<cr>',
        desc = 'open pop-up containing [I]nfo',
        ft = { 'leetcode.nvim' }
    }, {
        '<leader>ly',
        '<cmd> Leet yank<cr>',
        desc = '[Y]ank current solution',
        ft = { 'leetcode.nvim' }
    }, {
        '<leader>ll',
        '<cmd> Leet lang<cr>',
        desc = 'change [L]anguage',
        ft = { 'leetcode.nvim' }
    }, {
        '<leader>lr',
        '<cmd> Leet run<cr>',
        desc = '[R]un current solution',
        ft = { 'leetcode.nvim' }
    }, {
        '<leader>lt',
        '<cmd> Leet test<cr>',
        desc = '[T]est current solution',
        ft = { 'leetcode.nvim' }
    }, {
        '<leader>ls',
        '<cmd> Leet submit<cr>',
        desc = '[S]ubmit current solution',
        ft = { 'leetcode.nvim' }
    }, {
        '<leader>ld',
        '<cmd> Leet desc<cr>',
        desc = 'toggle question [D]escription',
        ft = { 'leetcode.nvim' }
    },
    },
}
