local ts_ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }
return {
    {
        'dmmulroy/tsc.nvim',
        ft = ts_ft,
        opts = {
            auto_open_qflist = false,
            auto_start_watch_mode = true,
            bin_bath = 'npx tsc',
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
        },
        init = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = ts_ft,
                group = vim.api.nvim_create_augroup('disable-ts_ls', { clear = true }),
                callback = function()
                    vim.lsp.enable('ts_ls', false)
                end
            })
        end,
        keys = {
            {
                '<leader>cm',
                function() vim.cmd('TSToolsAddMissingImports') end,
                desc = 'LSP: Add Missing Imports',
                ft = ts_ft
            },
            {
                '<leader>co',
                function() vim.cmd('TSToolsOrganizeImports') end,
                desc = 'LSP: Sort and Remove Unused Imports',
                ft = ts_ft
            },
            {
                '<leader>cf',
                function() vim.cmd('TSToolsFixAll') end,
                desc = 'LSP: Fix all fixable errors',
                ft = ts_ft
            },
            {
                '<leader>cr',
                function() vim.cmd('TSToolsRemoveUnused') end,
                desc = 'LSP: Remove all unused statements',
                ft = ts_ft
            },
            {
                '<leader>rf',
                function() vim.cmd('TSToolsRenameFile') end,
                desc = 'Rename File',
                ft = ts_ft
            },
        }
    }
}
