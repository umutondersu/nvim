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
        'zbirenbaum/copilot-cmp',
        opts = {},
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
        },
        opts = {
            debug = false,
            window = { width = 0.45 },
            mappings = {
                complete = {
                    insert = '',
                },
            },
            prompts = {
                Review = {
                    prompt = '/COPILOT_REVIEW Review the selected code.',
                    callback = function() end
                },
            },

        },
        config = function(_, opts)
            local chat = require("CopilotChat")
            local map = vim.keymap.set
            local actions = require("CopilotChat.actions")
            chat.setup(opts)
            require("CopilotChat.integrations.cmp").setup()
            map('n', '<leader>cw', function() chat.toggle() end, { desc = 'Toggle Chat [W]indow' })
            map('n', '<leader>cr', function() chat.reset() end, { desc = '[R]eset Chat Buffer' })
            map('n', "<leader>cc",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then require("CopilotChat").ask(input) end
                end,
                { desc = "Quick [C]hat" })
            map('v', "<leader>cc",
                function()
                    local input = vim.fn.input("Chat with visual: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input,
                            { selection = require("CopilotChat.select").visual })
                    end
                end,
                { desc = "[C]hat with Visual" })
            map('n', "<leader>cb",
                function()
                    local input = vim.fn.input("Chat with buffer: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input,
                            { selection = require("CopilotChat.select").buffer })
                    end
                end,
                { desc = "Chat with Buffer" })
            map({ 'x', 'n' }, '<leader>cp',
                function()
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
                { desc = 'Select [P]rompt Action' })
            map({ 'n' }, '<leader>cP',
                function()
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions({
                        selection = require("CopilotChat.select").buffer,
                    }))
                end,
                { desc = 'Select [P]rompt Action on buffer' })
        end
    },
}
