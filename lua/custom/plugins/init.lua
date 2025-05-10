return {
    { 'ThePrimeagen/vim-be-good',                    cmd = 'VimBeGood' },
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    'tpope/vim-repeat', -- Make most of the plugins repeatable with .
    { 'anuvyklack/help-vsplit.nvim',                 opts = {} },
    { 'numToStr/Comment.nvim',                       opts = {},                             event = 'BufReadPost' },
    { 'JoosepAlviste/nvim-ts-context-commentstring', dependencies = 'numToStr/Comment.nvim' },
    { 'danitrap/cheatsh.nvim',                       cmd = { 'CheatSh' } },
    { 'max397574/colortils.nvim',                    cmd = 'Colortils',                     opts = {} },
}
