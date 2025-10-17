return {
    'ChuufMaster/buffer-vacuum',
    lazy = false,
    opts = {
        max_buffers = 4,
        count_pinned_buffers = false,
        enable_messages = false,
    },
    keys = {
        {
            '<C-x>',
            '<cmd>BufferVacuumPinBuffer<CR>',
            desc = 'Pin/Unpin Buffer',
        },
        {
            ']p',
            '<cmd>BufferVacuumNext<CR>',
            desc = 'Next Pinned Buffer',
        },
        {
            '[P',
            '<cmd>BufferVacuumNext<CR>',
            desc = 'Next Pinned Buffer',
        },
        {
            '[p',
            '<cmd>BufferVacuumPrev<CR>',
            desc = 'Previous Pinned Buffer',
        },
        {
            ']P',
            '<cmd>BufferVacuumPrev<CR>',
            desc = 'Previous Pinned Buffer',
        }
    }
}
