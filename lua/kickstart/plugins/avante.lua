local config = require('kickstart.avante-config')
return {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = vim.tbl_deep_extend("keep", {
        provider = 'copilot_gemini',
        selector = { provider = 'snacks' },
        hints = { enabled = false },
        behaviour = {
            enable_token_counting = false,
        },
        system_prompt = function()
            local hub = require("mcphub").get_hub_instance()
            ---@diagnostic disable-next-line: need-check-nil
            return hub:get_active_servers_prompt() .. config.system_prompt
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
            "delete_dir",
        }
    }, config.providers),
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' -- for windows
    dependencies = {
        'stevearc/dressing.nvim',
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'zbirenbaum/copilot.lua',                                        -- Copilot Provider
        'folke/snacks.nvim',                                             -- Selector Provider
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
                    embed_image_as_base64s = false,
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
    keys = config.prompts,
}
