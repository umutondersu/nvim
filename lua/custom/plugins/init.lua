return
{ {
    'ThePrimeagen/vim-be-good',
    event = "VeryLazy",
}, {
    'famiu/bufdelete.nvim'
}, {
    'anuvyklack/help-vsplit.nvim',
    opts = {},
}, {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
}, {
    "dmmulroy/tsc.nvim",
    event = "VeryLazy",
    opts = {},
}, {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
}, {
    'ibhagwan/smartyank.nvim',
    opts = {},
}, {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
}, {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    opts = { width = 115, mappings = { enabled = true } },
}, {
    -- <a-n> and <a-p> as keymaps to move between references and <a-i> as a textobject for the reference illuminated under the cursor
    'RRethy/vim-illuminate',
}, {
    "rest-nvim/rest.nvim",
    dependencies = { { "j-hui/fidget.nvim", opts = {} } },
    ft = "http",
},
}
