return {
    { 'ThePrimeagen/vim-be-good',                    cmd = 'VimBeGood' },
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    'tpope/vim-repeat', -- Make most of the plugins repeatable with .
    { 'anuvyklack/help-vsplit.nvim',                 opts = {} },
    { 'numToStr/Comment.nvim',                       opts = {},                              event = 'BufReadPost' },
    { 'JoosepAlviste/nvim-ts-context-commentstring', dependencies = 'numToStr/Comment.nvim' },
    { 'danitrap/cheatsh.nvim',                       cmd = { 'CheatSh' } },
    { 'aliqyan-21/wit.nvim',                         cmd = { 'WitSearch', 'WitSearchWiki' }, opts = {} },
    { 'max397574/colortils.nvim',                    cmd = 'Colortils',                      opts = {} },
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    }
}
