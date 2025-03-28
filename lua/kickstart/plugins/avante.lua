return
{
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
        provider = 'claude',
        claude = { disable_tools = true },
        gemini = { model = 'gemini-2.5-pro-exp-03-25', disable_tools = true },
        vendors = {
            groq = {
                __inherited_from = "openai",
                api_key_name = "GROQ_API_KEY",
                endpoint = "https://api.groq.com/openai/v1/",
                model = "deepseek-r1-distill-llama-70b",
                disable_tools = true
            },
        },
        file_selector = { provider = 'snacks' },
        system_prompt = function()
            local hub = require("mcphub").get_hub_instance()
            ---@diagnostic disable-next-line: need-check-nil
            return hub:get_active_servers_prompt()
        end,
        -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
        custom_tools = function()
            return {
                require("mcphub.extensions.avante").mcp_tool(),
            }
        end,
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' -- for windows
    dependencies = {
        'stevearc/dressing.nvim',
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'folke/snacks.nvim',                                             -- file selector provider
        {                                                                -- MCP Integration
            "ravitemer/mcphub.nvim",
            dependencies = "nvim-lua/plenary.nvim",                      -- Required for Job and HTTP requests
            build = "npm install -g mcp-hub@latest",                     -- Installs required mcp-hub npm module
            opts = {
                port = 3000,                                             -- Port for MCP Hub server
                config = vim.fn.stdpath("config") .. "/mcpservers.json", -- Path to config file in Neovim config directory
                shutdown_delay = 0,                                      -- Wait 0ms before shutting down server after last client exits
                log = {
                    level = vim.log.levels.WARN,
                    to_file = false,
                    file_path = nil,
                    prefix = "MCPHub"
                },
            }
        },
        --- The below dependencies are optional,
        'echasnovski/mini.icons',
        'MeanderingProgrammer/render-markdown.nvim',
        {
            -- support for image pasting
            'HakonHarnes/img-clip.nvim',
            event = 'VeryLazy',
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
            '<leader>apT',
            function()
                require('avante.api').ask { question = 'Translate this into Spanish, but keep any code blocks inside intact' }
            end,
            mode = { 'n', 'v' },
            desc = 'Translate text',
        },
        {
            '<leader>ape',
            function()
                require('avante.api').ask { question = 'Explain the following code. Do not edit or suggest code' }
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
            '<leader>apc',
            function()
                require('avante.api').ask { question = 'Create a commit message for the following staged changes. If there are no staged changes, create the message for the unstaged changes' }
            end,
            mode = { 'n', 'v' },
            desc = 'Create Commit Message',
            ft = { 'fugitive', 'gitcommit' },
        },
        {
            '<leader>apr',
            function()
                require('avante.api').ask { question = 'Update the README.md with the staged changes. If there are no staged changes, create the message for the unstaged changes' }
            end,
            mode = { 'n', 'v' },
            desc = 'Update README',
            ft = { 'fugitive', 'gitcommit' },
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
        {
            '<leader>apt',
            function()
                require('avante.api').ask { question = 'Check the results of the test to give me suggestions in my code to fix errors if any' }
            end,
            mode = { 'n', 'v' },
            desc = 'Give Test Feedback',
            ft = 'neotest-output-panel'
        },
    },
}
