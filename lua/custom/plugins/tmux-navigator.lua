return {
    'christoomey/vim-tmux-navigator',
    enabled = vim.fn.has("win32") == 0,
    cmd = {
        'TmuxNavigateLeft',
        'TmuxNavigateDown',
        'TmuxNavigateUp',
        'TmuxNavigateRight',
        'TmuxNavigatePrevious',
    },
    keys = {
        { '<C-h>', '<cmd>TmuxNavigateLeft<cr>',  'window left' },
        { '<C-j>', '<cmd>TmuxNavigateDown<cr>',  'window down' },
        { '<C-k>', '<cmd>TmuxNavigateUp<cr>',    'window up' },
        { '<C-l>', '<cmd>TmuxNavigateRight<cr>', 'window right' },
    },
}
