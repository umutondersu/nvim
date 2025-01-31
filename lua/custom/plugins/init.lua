return
{ {
    'ThePrimeagen/vim-be-good',
    event = "VeryLazy",
}, {
    'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
}, {
    'anuvyklack/help-vsplit.nvim',
    opts = {},
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
    'numToStr/Comment.nvim',
    opts = {}
}, {
    'danitrap/cheatsh.nvim',
}, {
    "aliqyan-21/wit.nvim",
    opts = {},
}, {
    "max397574/colortils.nvim",
    cmd = "Colortils",
    opts = {},
},
}
