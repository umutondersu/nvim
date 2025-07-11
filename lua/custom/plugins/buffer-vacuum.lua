return {
    'ChuufMaster/buffer-vacuum',
    lazy = false,
    opts = {
        max_buffers = 3,
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
            '<M-x>',
            '<cmd>BufferVacuumPinBuffer<CR>',
            desc = 'Pin/Unpin Buffer',
        }
    }
}
