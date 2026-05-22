return {
    'nvim-java/nvim-java',
    ft = 'java',
    config = function()
        require('java').setup()
    end,
    keys = {
        {
            '<leader>tc',
            function() require('java').test.run_current_class() end,
            desc = 'Run Current Class'
        },
        {
            '<leader>tm',
            function() require('java').test.run_current_method() end,
            desc = 'Run Current Method'
        },
        {
            '<leader>tr',
            function() require('java').test.view_last_report() end,
            desc = 'View Last Report'
        },
        {
            '<leader>ct',
            function() require('java').runner.built_in.toggle_logs() end,
            desc = 'Toggle Logs'
        },
        {
            '<leader>re',
            function() require('java').refactor.extract_variable() end,
            desc = 'Extract Variable'
        },
        {
            '<leader>ra',
            function() require('java').refactor.extract_variable_all_occurrence() end,
            desc = 'Extract Variable All Occurrences'
        },
        {
            '<leader>rc',
            function() require('java').refactor.extract_constant() end,
            desc = 'Extract Constant'
        },
        {
            '<leader>rm',
            function() require('java').refactor.extract_method() end,
            desc = 'Extract Method'
        },
        {
            '<leader>rl',
            function() require('java').refactor.extract_field() end,
            desc = 'Extract Field'
        },
    },
}
