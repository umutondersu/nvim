return {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    init = function() vim.g.netrw_nogx = 1 end, -- disable netrw gx
    config = true,
}
