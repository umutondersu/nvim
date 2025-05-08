return {
    'mbbill/undotree',
    init = function()
        vim.keymap.set('n', '<leader>su', vim.cmd.UndotreeToggle, { desc = 'Undo Tree' })
    end
}
