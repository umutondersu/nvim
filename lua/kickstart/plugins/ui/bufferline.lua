local icons = require('kickstart.icons')
return {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
        { '<A-P>', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Buffer Pin' },
        { '<A-x>', '<cmd>BufferLinePick<cr>',      desc = 'Pick Buffer' },
        { '<A-.>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
        { '<A-,>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
        { '<A->>', '<cmd>BufferLineMoveNext<cr>',  desc = 'Prev Buffer' },
        { '<A-<>', '<cmd>BufferLineMovePrev<cr>',  desc = 'Next Buffer' },
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
