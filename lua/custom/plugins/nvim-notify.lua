return {
    'rcarriga/nvim-notify',
    enable = true,
    config = function()
        require('notify').setup({})
        vim.notify = require("notify")
    end
}

