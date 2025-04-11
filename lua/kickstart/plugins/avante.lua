return
{
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = vim.tbl_deep_extend("keep", {
        provider = 'copilot',
        file_selector = { provider = 'snacks' },
        system_prompt = function()
            local hub = require("mcphub").get_hub_instance()
            ---@diagnostic disable-next-line: need-check-nil
            return hub:get_active_servers_prompt()
        end,
        -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
        custom_tools = function()
            return { require("mcphub.extensions.avante").mcp_tool() }
        end,
        disabled_tools = { -- To prevent conflicts with the built-in neovim server of MCP Hub
            "list_files",
            "search_files",
            "read_file",
            "create_file",
            "rename_file",
            "delete_file",
            "create_dir",
            "rename_dir",
            "delete_dir"
        }
    }, require("kickstart.avante-providers")),
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
            cmd = "MCPHub",                                              -- lazy load by default
            opts = {
                port = 37373,                                            -- Default port for MCP Hub
                config = vim.fn.stdpath("config") .. "/mcpservers.json", -- Path to config file in Neovim config directory
                auto_approve = true,                                     -- Automatically approve servers
                extensions = { avante = { make_slash_commands = true } } -- Enable avante extension
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
            '<leader>apT',
            function()
                require('avante.api').ask { question = 'Translate this into Spanish, but keep any code blocks inside intact' }
            end,
            mode = { 'n', 'v' },
            desc = 'Translate text',
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
                require('avante.api').ask { question = 'Create a commit message for the following staged changes, while keeping it consise and not too verbose. If there are no staged changes, create the message for the unstaged changes' }
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
            '<leader>apg',
            function()
                require('avante.api').ask { question = [[
Please improve the English in this text while:
1. Preserving all code blocks and technical terms exactly as they are
2. Maintaining the original meaning and tone
3. Following standard English grammar and style conventions
4. Keeping formatting (lists, paragraphs, etc.) intact
]] }
            end,
            mode = { 'n', 'v' },
            desc = 'Grammar Correction',
        },
        {
            '<leader>apm',
            function()
                require('avante.api').ask { question = [[
Identify and extract:
1. Key technical terms and concepts
2. Important function/class names
3. Significant variable names
4. Core topics and themes
5. Domain-specific terminology

Present keywords in categories with brief context for each.
]] }
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
                require('avante.api').ask { question = [[
Analyze and optimize this code for:
1. Performance improvements
2. Better readability
3. Memory efficiency
4. Best practices in the language
Explain each optimization and its benefits.
]] }
            end,
            mode = { 'n', 'v' },
            desc = 'Optimize Code',
        },
        {
            '<leader>aps',
            function()
                require('avante.api').ask { question = [[
Create a concise summary that:
1. Captures the main points and key ideas
2. Preserves essential technical details
3. Maintains the logical flow of information
4. Keeps any critical code references intact
Present the summary in bullet points if the text is technical or instructional.
]] }
            end,
            mode = { 'n', 'v' },
            desc = 'Summarize text',
        },
        {
            '<leader>ape',
            function()
                require('avante.api').ask { question = [[
Provide a clear explanation of this code by:
1. Breaking down its purpose and functionality
2. Explaining key algorithms or patterns used
3. Describing the flow of execution
4. Highlighting important functions/methods
5. Noting any significant dependencies or assumptions

Focus on explanation only - do not suggest modifications or improvements.
]] }
            end,
            mode = { 'n', 'v' },
            desc = 'Explain Code',
        },

        {
            '<leader>apD',
            function()
                require('avante.api').ask { question = [[
Add comprehensive docstrings that include:
1. A clear description of purpose and functionality
2. All parameters with their types and descriptions
3. Return values and their types
4. Usage examples where appropriate
5. Any important notes or exceptions

Follow the language's standard docstring format and style conventions.
]] }
            end,
            mode = { 'n', 'v' },
            desc = 'Add Docstring',
        },
        {
            '<leader>apd',
            function()
                require('avante.api').ask { question = [[
Use available diagnostic tools to analyze and fix any diagnostic issues.

For each diagnostic found:
1. Group related issues across files
2. Explain each error/warning in plain language
3. Provide and apply a solution that follows language best practices
4. Ensure the fix maintains existing functionality
5. Address any type safety and compatibility concerns
6. Do not overreach, only fix what is necessary

Prioritize fixes that resolve multiple related issues.
]] }
            end,
            mode = { 'n', 'v' },
            desc = 'Fix Diagnostics',
        },
        {
            '<leader>apD',
            function()
                require('avante.api').ask { question = [[
YOLO
Use available diagnostic tools to analyze and fix any diagnostic issues.

For each diagnostic found:
1. Group related issues across files
2. Explain each error/warning in plain language
3. Provide and apply a solution that follows language best practices
4. Ensure the fix maintains existing functionality
5. Address any type safety and compatibility concerns
6. Do not overreach, only fix what is necessary

Be autonomous, change the code without user input by using the tools available to you.

After suggesting fixes, verify that no new diagnostics would be introduced by checking the diagnostics again.
If diagnostics are still present, repeat the process until all are resolved.

Prioritize fixes that resolve multiple related issues.
]] }
            end,
            mode = { 'n', 'v' },
            desc = 'Fix Diagnostics YOLO',
        },
        {
            '<leader>apb',
            function()
                require('avante.api').ask { question = [[
Analyze the code for potential bugs and issues:
1. Check for logical errors and edge cases
2. Identify potential runtime errors
3. Look for common pitfalls in the language/framework
4. Analyze error handling and validation
5. Review type safety and data validation

For each issue found:
- Explain the bug's impact and potential risks
- Provide a clear fix that follows best practices
- Verify the fix doesn't introduce new issues
- Consider performance and side effects
- Suggest preventive measures for similar bugs

Include test scenarios to verify the fixes if appropriate.
]] }
            end,
            mode = { 'n', 'v' },
            desc = 'Fix Bugs',
        },

        {
            '<leader>apb',
            function()
                require('avante.api').ask { question = [[
Analyze the code for potential bugs and issues:
1. Check for logical errors and edge cases
2. Identify potential runtime errors
3. Look for common pitfalls in the language/framework
4. Analyze error handling and validation
5. Review type safety and data validation

For each issue found:
- Explain the bug's impact and potential risks
- Provide a clear fix that follows best practices
- Verify the fix doesn't introduce new issues
- Consider performance and side effects
- Suggest preventive measures for similar bugs

Include test scenarios to verify the fixes if appropriate.
]] }
            end,
            mode = { 'n', 'v' },
            desc = 'Fix Bugs',
        },
        {
            '<leader>apt',
            function()
                require('avante.api').ask { question = [[
Generate comprehensive tests that:
1. Cover core functionality
   - Happy path scenarios
   - Edge cases and error conditions
   - Input validation
   - Expected outputs

2. Follow testing best practices
   - Clear test descriptions
   - Isolated test cases
   - Meaningful assertions
   - Proper setup and teardown

3. Include different test types
   - Unit tests
   - Integration tests where needed
   - Error handling tests
   - Performance tests if relevant

4. Consider test coverage
   - Key functionality paths
   - Edge cases
   - Error conditions
   - Common use cases

Follow the project's existing testing patterns and frameworks.
]] }
            end,
            mode = { 'n', 'v' },
            desc = 'Add Tests',
        },
        {
            '<leader>apt',
            function()
                require('avante.api').ask { question = [[
Analyze the test results and provide structured feedback with fixes:
1. Summary of test execution
   - Total tests run/passed/failed
   - Critical failures or blocking issues
   - Performance-related concerns

2. For each failing test:
   - Root cause analysis
   - Code path that triggered the failure
   - Expected vs actual behavior
   - PROVIDE DIRECT CODE FIXES with explanations
   - Generate corrected implementation

3. Pattern Analysis & Fixes:
   - Common failure themes with code-level solutions
   - Areas needing more test coverage with example tests
   - Fix architectural issues with refactoring suggestions
   - Resolve performance bottlenecks with optimized code

4. Implementation of Fixes:
   - Provide ready-to-use code fixes
   - Include error handling improvements
   - Add missing edge case handling
   - Implement test suite enhancements

Prioritize fixes based on severity and provide complete, working code solutions.
]] }
            end,
            mode = { 'n', 'v' },
            desc = 'Test Feedback',
            ft = 'neotest-output-panel'
        },
    },
}
