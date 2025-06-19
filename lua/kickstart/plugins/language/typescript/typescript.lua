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
        },
        init = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = ts_ft,
                group = vim.api.nvim_create_augroup('disable-ts_ls', { clear = true }),
                callback = function()
                    vim.lsp.enable('ts_ls', false)
                end
            })
            vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
                pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
                group = vim.api.nvim_create_augroup('ts-autoformat', { clear = true }),
                callback = function(event)
                    if vim.g.disable_autoformat or vim.b[event.buf].disable_autoformat or vim.g.disable_tsautoformat then
                        return
                    end

                    vim.cmd('TSToolsAddMissingImports')
                    vim.cmd('TSToolsOrganizeImports')

                    -- Wait up to a second for commands to complete. Retry every 10ms
                    local success = vim.wait(1000, function()
                        return vim.bo[event.buf].modified
                    end, 10)

                    if success and vim.bo[event.buf].modified then
                        vim.api.nvim_buf_call(event.buf, function()
                            vim.cmd('silent! write')
                        end)
                    end
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
            {
                '<leader>fT',
                function()
                    vim.g.disable_tsautoformat = not vim.g.disable_tsautoformat
                    vim.notify('TS Auto Formatting is ' ..
                        (vim.g.disable_tsautoformat and 'Disabled' or 'Enabled'))
                end,
                desc = 'Toggle TS Auto Formatting',
                ft = ts_ft
            },
        }
    }
}
