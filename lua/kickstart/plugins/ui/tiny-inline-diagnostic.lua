return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000, -- needs to be loaded in first
    opts = {
        preset = 'amongus',
        options = {
            show_source = {
                enabled = true, -- enable showing sources
                if_many = true  -- only show when multiple different sources exist
            }
        },
        hi = { background = "None" }
    },
    init = function() vim.diagnostic.config { virtual_text = false } end
}
