return {
    { 'ThePrimeagen/vim-be-good',                    cmd = 'VimBeGood' },
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    'tpope/vim-repeat', -- Make most of the plugins repeatable with .
    { 'anuvyklack/help-vsplit.nvim',                 opts = {} },
    { 'numToStr/Comment.nvim',                       event = 'BufReadPost', opts = {} },
    { 'JoosepAlviste/nvim-ts-context-commentstring', event = 'InsertEnter' },
    { 'max397574/colortils.nvim',                    cmd = 'Colortils',     opts = {} },
    { 'mluders/comfy-line-numbers.nvim',             opts = {},             event = 'VimEnter' }
}
