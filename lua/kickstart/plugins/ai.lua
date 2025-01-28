return {
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        opts = {
            panel = {
                enabled = false,
            },
            suggestion = {
                enabled = false,
            },
            filetypes = {
                yaml = false,
                markdown = false,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ['.'] = false,
            },
            copilot_node_command = 'node',
            server_opts_overrides = {},
        }
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false, -- set this if you want to always pull the latest change
        opts = {
            provider = "copilot",
            file_selector = { provider = "snacks" }
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            "folke/snacks.nvim",      -- file selector provider
            --- The below dependencies are optional,
            "echasnovski/mini.icons",
            "MeanderingProgrammer/render-markdown.nvim",
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
        },
        keys = {
            {
                '<leader>apg',
                function()
                    require('avante.api').ask { question = 'Correct the text to standard English, but keep any code blocks inside intact.' }
                end,
                mode = { 'n', 'v' },
                desc = 'Grammar Correction',
            },
            {
                '<leader>apm',
                function()
                    require('avante.api').ask { question = 'Extract the main keywords from the following text' }
                end,
                mode = { 'n', 'v' },
                desc = 'Extract Main Keywords',
            },
            {
                '<leader>apr',
                function()
                    require('avante.api').ask { question = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]] }
                end,
                mode = { 'n', 'v' },
                desc = 'Code Readability Analysis',
            },
            {
                '<leader>apo',
                function()
                    require('avante.api').ask { question = 'Optimize the following code' }
                end,
                mode = { 'n', 'v' },
                desc = 'Optimize Code',
            },
            {
                '<leader>aps',
                function()
                    require('avante.api').ask { question = 'Summarize the following text' }
                end,
                mode = { 'n', 'v' },
                desc = 'Summarize text',
            },
            {
                '<leader>apt',
                function()
                    require('avante.api').ask { question = 'Translate this into Spanish, but keep any code blocks inside intact' }
                end,
                mode = { 'n', 'v' },
                desc = 'Translate text',
            },
            {
                '<leader>ape',
                function()
                    require('avante.api').ask { question = 'Explain the following code' }
                end,
                mode = { 'n', 'v' },
                desc = 'Explain Code',
            },
            {
                '<leader>apc',
                function()
                    require('avante.api').ask { question = 'Complete the following codes written in ' .. vim.bo.filetype }
                end,
                mode = { 'n', 'v' },
                desc = 'Complete Code',
            },
            {
                '<leader>apD',
                function()
                    require('avante.api').ask { question = 'Add docstring to the following codes' }
                end,
                mode = { 'n', 'v' },
                desc = 'Add Docstring',
            },
            {
                '<leader>apd',
                function()
                    require('avante.api').ask { question = 'Fix the diagnostics inside the following codes if any @diagnostics' }
                end,
                mode = { 'n', 'v' },
                desc = 'Fix Diagnostics',
            },
            {
                '<leader>apb',
                function()
                    require('avante.api').ask { question = 'Fix the bugs inside the following codes if any' }
                end,
                mode = { 'n', 'v' },
                desc = 'Fix Bugs',
            },
            {
                '<leader>apt',
                function()
                    require('avante.api').ask { question = 'Implement tests for the following code' }
                end,
                mode = { 'n', 'v' },
                desc = 'Add Tests',
            },
        },
    },
}
