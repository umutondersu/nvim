return {
    'ibhagwan/smartyank.nvim',
    init = function()
        local map = vim.keymap.set
        -- Sync only puts and x cuts with system clipboard (smartyank required)
        map({ 'n', 'v' }, 'p', '"+p', { silent = true })
        map({ 'n', 'v' }, 'P', '"+P', { silent = true })
        map({ 'n', 'v' }, 'x', '"+d', { silent = true })
        map({ 'n', 'v' }, 'X', '"+D', { silent = true })
    end,

}
