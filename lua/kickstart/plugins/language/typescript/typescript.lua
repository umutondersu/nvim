local ts_ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }
return {
    {
        'dmmulroy/tsc.nvim',
        ft = ts_ft,
        opts = {
            auto_open_qflist = false,
            auto_start_watch_mode = true,
            flags = { watch = true },
            use_diagnostics = true,
            enable_progress_notifications = false,
            enable_error_notifications = false
        }
    },
    { 'dmmulroy/ts-error-translator.nvim', ft = ts_ft },
    {
        'pmizio/typescript-tools.nvim',
        ft = ts_ft,
        dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
        opts = {
            settings = {
                tsserver_file_preferences = {
                    includeInlayEnumMemberValueHints = true,
                    includeInlayFunctionLikeReturnTypeHints = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayVariableTypeHints = true,
                }
            }
        }
    }
}
