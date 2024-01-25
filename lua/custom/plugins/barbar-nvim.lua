-- NOTE: don't use it with harpoon. disable one or the other
return {
    'romgrk/barbar.nvim',
    enabled = true,
    dependencies = {
        'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    opts = {
        -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
        -- insert_at_start = true,
        -- …etc.
        animation = true,
        clickable = true,
        auto_hide = true,
        sidebar_filetypes = {
            -- Use the default values: {event = 'BufWinLeave', text = nil}
            NvimTree = true,
        },
        icons = {
            button = ' ',
            separator_at_end = false,
        },
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
    init = function() vim.g.barbar_auto_setup = false end,
    config = function(_, opts)
        require('barbar').setup(opts)
        local map = vim.keymap.set
        local options = { noremap = true, silent = true }

        -- Move to previous/next
        map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', options)
        map('n', '<A-.>', '<Cmd>BufferNext<CR>', options)
        -- Re-order to previous/next
        map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', options)
        map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', options)
        -- Goto buffer in position...
        map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', options)
        map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', options)
        map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', options)
        map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', options)
        map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', options)
        map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', options)
        map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', options)
        map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', options)
        map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', options)
        map('n', '<A-0>', '<Cmd>BufferLast<CR>', options)
        -- Pin/unpin buffer
        map('n', '<A-P>', '<Cmd>BufferPin<CR>', options)
        -- Close buffer
        map('n', '<A-c>', '<Cmd>BufferClose<CR>', options)
        -- Wipeout buffer
        --                 :BufferWipeout
        -- Close commands
        --                 :BufferCloseAllButCurrent
        --                 :BufferCloseAllButPinned
        --                 :BufferCloseAllButCurrentOrPinned
        --                 :BufferCloseBuffersLeft
        --                 :BufferCloseBuffersRight
        -- Magic buffer-picking mode
        map('n', '<A-x>', '<Cmd>BufferPick<CR>', options)
        -- Sort automatically by...
        -- map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
        -- map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
        -- map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
        -- map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
        -- Other:
        -- :BarbarEnable - enables barbar (enabled by default)
        -- :BarbarDisable - very bad command, should never be used
    end,
}

