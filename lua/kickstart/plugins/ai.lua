return {
    {
        'milanglacier/minuet-ai.nvim',
        opts = {
            provider = 'openai_fim_compatible',
            n_completions = 1, -- recommend for local model for resource saving
            -- I recommend you start with a small context window firstly, and gradually
            -- increase it based on your local computing power.
            context_window = 512,
            provider_options = {
                openai_fim_compatible = {
                    api_key = 'TERM',
                    name = 'Ollama',
                    end_point = 'http://localhost:11434/v1/completions',
                    model = 'qwen2.5-coder',
                    stream = true,
                    optional = {
                        max_tokens = 256,
                        top_p = 0.9,
                    },
                },
            },
        }
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false, -- set this if you want to always pull the latest change
        opts = {
            file_selector = { provider = 'snacks' },
            provider = 'ollama',
            vendors = {
                ---@type AvanteProvider
                ollama = {
                    api_key_name = "",
                    ask = "",
                    endpoint = "http://127.0.0.1:11434/api",
                    model = "qwen2.5-coder",
                    parse_curl_args = function(opts, code_opts)
                        return {
                            url = opts.endpoint .. "/chat",
                            headers = {
                                ["Accept"] = "application/json",
                                ["Content-Type"] = "application/json",
                            },
                            body = {
                                model = opts.model,
                                options = {
                                    num_ctx = 32768
                                },
                                messages = require("avante.providers").copilot.parse_messages(code_opts), -- you can make your own message, but this is very advanced
                                stream = true,
                            },
                        }
                    end,
                    parse_stream_data = function(data, handler_opts)
                        -- Parse the JSON data
                        local json_data = vim.fn.json_decode(data)
                        -- Check for stream completion marker first
                        if json_data and json_data.done then
                            handler_opts.on_complete(nil) -- Properly terminate the stream
                            return
                        end
                        -- Process normal message content
                        if json_data and json_data.message and json_data.message.content then
                            -- Extract the content from the message
                            local content = json_data.message.content
                            -- Call the handler with the content
                            handler_opts.on_chunk(content)
                        end
                    end,
                },
            }
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
