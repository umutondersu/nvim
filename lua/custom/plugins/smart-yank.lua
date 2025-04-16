return {
    'ibhagwan/smartyank.nvim',
    event = 'TextYankPost',
    opts = { highlight = { enabled = false } },
    init = function()
        local map = function(lhs, rhs)
            vim.keymap.set({ 'n', 'v' }, lhs, rhs, { silent = true })
        end
        -- Sync put (p) and cut (x) with system clipboard
        map('p', '"+p')
        map('P', '"+P')
        map('x', '"+d')
        map('X', '"+D')
    end,

}
