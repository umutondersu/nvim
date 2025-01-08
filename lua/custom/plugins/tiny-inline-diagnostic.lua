return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000, -- needs to be loaded in first
    opts = {
        preset = 'amongus',
    },
    config = function(_, opts)
        -- Disable default virtual text
        vim.diagnostic.config { virtual_text = false }
        require('tiny-inline-diagnostic').setup(opts)
    end
}
