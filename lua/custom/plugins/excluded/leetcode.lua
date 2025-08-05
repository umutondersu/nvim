local leet_arg = 'leetcode.nvim'
return {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    dependencies = {
        "folke/snacks.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = leet_arg ~= vim.fn.argv(0, -1),
    opts = {
        arg = leet_arg,
        lang = 'python3',
        -- directory = os.getenv('HOME') .. '/leetcode',
    },
    keys = { {
        '<leader>l',
        function()
        end,
        desc = '+Leetcode',
        ft = 'leetcode.nvim'
    }, {
        '<leader>lc',
        '<cmd> Leet console<cr>',
        desc = 'Open Console',
        ft = 'leetcode.nvim'
    }, {
        '<leader>li',
        '<cmd> Leet info<cr>',
        desc = 'Open Info',
        ft = 'leetcode.nvim'
    }, {
        '<leader>ly',
        '<cmd> Leet yank<cr>',
        desc = 'Yank solution',
        ft = 'leetcode.nvim'
    }, {
        '<leader>ll',
        '<cmd> Leet lang<cr>',
        desc = 'Change Language',
        ft = 'leetcode.nvim'
    }, {
        '<leader>lr',
        '<cmd> Leet run<cr>',
        desc = 'Run Solution',
        ft = 'leetcode.nvim'
    }, {
        '<leader>lt',
        '<cmd> Leet test<cr>',
        desc = 'Test Solution',
        ft = 'leetcode.nvim'
    }, {
        '<leader>ls',
        '<cmd> Leet submit<cr>',
        desc = 'Submit Solution',
        ft = 'leetcode.nvim'
    }, {
        '<leader>ld',
        '<cmd> Leet desc<cr>',
        desc = 'Togle Description',
        ft = 'leetcode.nvim'
    },
    },
}
