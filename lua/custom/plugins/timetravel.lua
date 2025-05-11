return {
    "y3owk1n/time-machine.nvim",
    cmd = {
        "TimeMachineToggle",
        "TimeMachinePurgeBuffer",
        "TimeMachinePurgeAll",
        "TimeMachineLogShow",
        "TimeMachineLogClear",
    },
    opts = {},
    keys = {
        {
            "<leader>su",
            "<cmd>TimeMachineToggle<cr>",
            desc = "Undo Tree",
        },
    },
    init = function()
        vim.opt.undodir = vim.fn.expand("~/.undodir") -- Set custom undo directory
    end
}
