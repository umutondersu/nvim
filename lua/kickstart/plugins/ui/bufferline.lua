local icons = require('kickstart.icons')
return {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
        { '<A-P>', '<Cmd>BufferLineTogglePin<CR>',     desc = 'Toggle Buffer Pin' },
        { '<A-x>', '<cmd>BufferLinePick<cr>',          desc = 'Pick Buffer' },
        { '<A-.>', '<cmd>BufferLineCycleNext<cr>',     desc = 'Next Buffer' },
        { '<A-,>', '<cmd>BufferLineCyclePrev<cr>',     desc = 'Prev Buffer' },
        { '<A-l>', '<cmd>BufferLineCycleNext<cr>',     desc = 'Next Buffer' },
        { '<A-h>', '<cmd>BufferLineCyclePrev<cr>',     desc = 'Prev Buffer' },
        { '<A->>', '<cmd>BufferLineMoveNext<cr>',      desc = 'Swap with Prev Buffer' },
        { '<A-<>', '<cmd>BufferLineMovePrev<cr>',      desc = 'Swap with Next Buffer' },
        { '<A-1>', '<cmd>BufferLineGoToBuffer 1<cr>',  desc = 'Go to Buffer 1' },
        { '<A-2>', '<cmd>BufferLineGoToBuffer 2<cr>',  desc = 'Go to Buffer 2' },
        { '<A-3>', '<cmd>BufferLineGoToBuffer 3<cr>',  desc = 'Go to Buffer 3' },
        { '<A-4>', '<cmd>BufferLineGoToBuffer 4<cr>',  desc = 'Go to Buffer 4' },
        { '<A-5>', '<cmd>BufferLineGoToBuffer 5<cr>',  desc = 'Go to Buffer 5' },
        { '<A-6>', '<cmd>BufferLineGoToBuffer 6<cr>',  desc = 'Go to Buffer 6' },
        { '<A-7>', '<cmd>BufferLineGoToBuffer 7<cr>',  desc = 'Go to Buffer 7' },
        { '<A-8>', '<cmd>BufferLineGoToBuffer 8<cr>',  desc = 'Go to Buffer 8' },
        { '<A-9>', '<cmd>BufferLineGoToBuffer 9<cr>',  desc = 'Go to Buffer 9' },
        { '<A-0>', '<cmd>BufferLineGoToBuffer -1<cr>', desc = 'Go to Last Buffer' },
    },
    opts = {
        ---@module 'snacks'
        options = {
            close_command = function(n) Snacks.bufdelete(n) end,
            right_mouse_command = function(n) Snacks.bufdelete(n) end,
            diagnostics = 'nvim_lsp',
            always_show_bufferline = true,
            diagnostics_indicator = function(_, _, diag)
                local ret = (diag.error and icons.diagnostics.Error .. diag.error .. ' ' or '')
                    .. (diag.warning and icons.diagnostics.Warn .. diag.warning or '')
                return vim.trim(ret)
            end,
            offsets = { { filetype = 'snacks_layout_box' } },
            ---@param opts bufferline.IconFetcherOpts
            get_element_icon = function(opts)
                return icons.ft[opts.filetype]
            end,
            buffer_close_icon = '',
            close_icon = '',
        },
    },
    config = function(_, opts)
        require('bufferline').setup(opts)
        -- Fix bufferline when restoring a session
        vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
            callback = function()
                vim.schedule(function()
                    pcall(nvim_bufferline)
                end)
            end,
        })
    end,
}
