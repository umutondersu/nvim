return {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = { -- dependencies
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
    },
    config = function()
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { desc = 'LSP: ' .. desc })
        end
        local gopher = require("gopher")
        gopher.setup({})
        map('<leader>lt', gopher.tags.add, 'Add JSON tags to struct fields')
        map('<leader>ld', '<cmd>GoCmt<cr>', 'Generate boilerplate for doc comments')
        map('<leader>tgf', gopher.test.add, 'Generate Test for the function under the cursor')
        map('<leader>tgF', gopher.test.all, 'Generate Test for all the functions in the file')
    end
}
