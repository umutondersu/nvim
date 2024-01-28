return {
    'tpope/vim-dadbod',
    event = 'VeryLazy',
    dependencies = {
        {
            'kristijanhusak/vim-dadbod-ui',
            cmd = {
                'DBUI',
                'DBUIToggle',
                'DBUIAddConnection',
                'DBUIFindBuffer',
            },
            init = function()
                -- Your DBUI configuration
                vim.g.db_ui_use_nerd_fonts = 1
            end,
        },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' } }
    }
}
