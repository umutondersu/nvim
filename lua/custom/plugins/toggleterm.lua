return {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
        {
            "<M-v>",
            "<cmd>ToggleTerm direction=vertical<CR>",
            mode = "",
            desc = "which_key_ignore",
        },
        {
            "<M-h>",
            "<cmd>ToggleTerm direction=horizontal<CR>",
            mode = "",
            desc = "which_key_ignore",
        },
        {
            "<C-w>h",
            "<Cmd>wincmd h<CR>",
            mode = "t",
            desc = "Move left from terminal",
        },
        {
            "<C-w>k",
            "<Cmd>wincmd k<CR>",
            mode = "t",
            desc = "Move up from terminal",
        },
        {
            "<C-w>j",
            "<Cmd>wincmd j<CR>",
            mode = "t",
            desc = "Move down from terminal",
        },
        {
            "<C-w>l",
            "<Cmd>wincmd l<CR>",
            mode = "t",
            desc = "Move right from terminal",
        },
    },
    config = function()
        require("toggleterm").setup {
            open_mapping = "<M-t>",
            size = function(term)
                if term.direction == "horizontal" then
                    return 10
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.28
                end
            end,
            direction = 'vertical',
        }
        if vim.fn.has("win32") == 1 then
            vim.cmd [[let &shell = '"C:/Program Files/Git/bin/bash.exe"']]
            vim.cmd [[let &shellcmdflag = '-s']]
        end
    end
}

