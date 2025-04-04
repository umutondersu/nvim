return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000, -- needs to be loaded in first
    opts = {
        preset = 'amongus',
        options = { show_source = true },
        hi = { background = "None" }
    },
    init = function() vim.diagnostic.config { virtual_text = false } end
}
