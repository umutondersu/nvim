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
                    -- For some reason buffer-vacuum keymap does not work in ts files unless set here
                    vim.keymap.set('n', '<C-x>', '<cmd>BufferVacuumPinBuffer<CR>', { desc = "Pin/Unpin Buffer" })
                end
            })
        end,
        keys = {
            {
                '<leader>cm',
                function() vim.cmd('TSToolsAddMissingImports') end,
                desc = 'Add Missing Imports',
                ft = ts_ft
            },
            {
                '<leader>co',
                function() vim.cmd('TSToolsOrganizeImports') end,
                desc = 'Sort and Remove Unused Imports',
                ft = ts_ft
            },
            {
                '<leader>cf',
                function() vim.cmd('TSToolsFixAll') end,
                desc = 'Fix all fixable errors',
                ft = ts_ft
            },
            {
                '<leader>cr',
                function() vim.cmd('TSToolsRemoveUnused') end,
                desc = 'Remove all unused statements',
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
