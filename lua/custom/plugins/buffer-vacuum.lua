return {
    'ChuufMaster/buffer-vacuum',
    dependencies = 'rmagatti/auto-session',
    opts = {
        max_buffers = 3,
        count_pinned_buffers = false,
        enable_messages = false,
    },
    init = function()
        vim.keymap.set('n', '<M-x>', '<cmd>BufferVacuumPinBuffer<CR>', { desc = 'Pin/Unpin Buffer' })
    end,
}
