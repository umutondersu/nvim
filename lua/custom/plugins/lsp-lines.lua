return {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
        require('lsp_lines').setup()
        -- Disable virtual lines for lsp-lines
        vim.diagnostic.config {
            virtual_text = false,
        }
    end,
}
