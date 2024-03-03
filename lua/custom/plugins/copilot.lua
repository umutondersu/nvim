return {
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        config = function()
            require('copilot').setup {
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
        end,
    },
    {
        'zbirenbaum/copilot-cmp',
        opts = {},
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        enabled = vim.fn.has("win32") == 0,
        event = "VeryLazy",
        keys = {
            { "<leader>cb", ":CopilotChatBuffer ",               desc = "CopilotChat - Chat with current buffer" },
            { "<leader>ce", "<cmd>CopilotChatExplain<cr>",       desc = "CopilotChat - Explain code [Prompt]" },
            { "<leader>ct", "<cmd>CopilotChatTests<cr>",         desc = "CopilotChat - Generate tests [Prompt]" },
            { "<leader>cv", "<cmd>CopilotChatVsplitToggle<cr>",  desc = "CopilotChat - Toggle Chat Window",      mode = "n" },
            { "<leader>cv", ":CopilotChatVisual ",               desc = "CopilotChat - Open in vertical split",  mode = "x" },
            { "<leader>cx", ":CopilotChatInPlace<cr>",           desc = "CopilotChat - Run in-place code",       mode = "x" },
            { "<leader>cf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix diagnostic" },
            { "<leader>cR", "<cmd>CopilotChatReset<cr>",         desc = "CopilotChat - Reset Chat Buffer" },
            { "<leader>cr", "<cmd>CopilotChatReview<cr>",        desc = "CopilotChat - Review code [Prompt]" },
            { "<leader>cE", "<cmd>CopilotChatRefactor<cr>",      desc = "CopilotChat - Refactor code [Prompt]" },
            {
                "<leader>ch",
                function() require("CopilotChat.code_actions").show_help_actions() end,
                desc = "CopilotChat - Help actions",
            },
            -- {
            --     "<leader>cp",
            --     function() require("CopilotChat.code_actions").show_prompt_actions() end,
            --     desc = "CopilotChat - Prompt actions",
            -- },
        },
        opts = {
            show_help = "yes",         -- Show help text for CopilotChatInPlace, default: yes
            debug = false,             -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
            disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
            language = "English",
            prompts = {
                Explain = "Explain how it works.",
                Review = "Review the following code and provide concise suggestions.",
                Tests = "Briefly explain how the selected code works, then generate unit tests.",
                Refactor = "Refactor the code to improve clarity and readability.",
            }
        },
        build = function()
            vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
        end,
    },
}
