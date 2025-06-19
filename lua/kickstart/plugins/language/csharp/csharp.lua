return {
    'Hoffs/omnisharp-extended-lsp.nvim',
    ft = 'cs',
    keys = {
        {
            'gd',
            function() require('omnisharp_extended').lsp_definition() end,
            desc = 'LSP: Goto Definition',
            ft = 'cs'
        },
        {
            'gy',
            function() require('omnisharp_extended').lsp_type_definition() end,
            desc = 'LSP: Goto Type Definition',
            ft = 'cs'
        },
        {
            'gr',
            function() require('omnisharp_extended').lsp_references() end,
            desc = 'LSP: Goto References',
            ft = 'cs'
        },
        {
            'gI',
            function() require('omnisharp_extended').lsp_implementation() end,
            desc = 'LSP: Goto Implementation',
            ft = 'cs'
        },
    },
}
