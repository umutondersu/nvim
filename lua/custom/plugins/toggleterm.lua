return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        open_mapping = [[<c-\>]],
        size = function(term)
            if term.direction == "horizontal" then
                return 10
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.27
            end
        end,
        direction = 'vertical',
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)
        if vim.fn.has("win32") == 1 then
            vim.cmd [[let &shell = '"C:/Program Files/Git/bin/bash.exe"']]
            vim.cmd [[let &shellcmdflag = '-s']]
        end
        local map = vim.keymap.set
        local mapopts = { noremap = true, silent = true }
        map({ 't' }, '<c-h>', '<Cmd>wincmd h<CR>', mapopts)
        map({ 't' }, '<c-k>', '<Cmd>wincmd k<CR>', mapopts)
        map({ 't' }, '<c-j>', '<Cmd>wincmd j<CR>', mapopts)
        map({ 't' }, '<c-l>', '<Cmd>wincmd l<CR>', mapopts)
        map({ 't' }, '<c-w>', [[<C-\><C-n><C-w>]], mapopts)
        map({ 't' }, '<esc>', [[<C-\><C-n>]], mapopts)
    end,
}

