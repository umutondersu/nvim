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
        "jellydn/CopilotChat.nvim",
        event = "VeryLazy",
        enabled = vim.fn.has("win32") == 0,
        opts = {
            mode = "split", -- newbuffer or split  , default: newbuffer
            prompts = {
                Explain = "Explain how it works.",
                Review = "Review the following code and provide concise suggestions.",
                Tests = "Briefly explain how the selected code works, then generate unit tests.",
                Refactor = "Refactor the code to improve clarity and readability.",
                Summarize = "Please summarize the following text.",
            },
        },
        build = function()
            vim.defer_fn(function()
                vim.cmd("UpdateRemotePlugins")
                vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
            end, 3000)
        end,
        keys = {
            { "<leader>Ce", "<cmd>CopilotChatExplain<cr>",   desc = "Explain code" },
            { "<leader>Ct", "<cmd>CopilotChatTests<cr>",     desc = "Generate tests" },
            { "<leader>Cr", "<cmd>CopilotChatReview<cr>",    desc = "Review code" },
            { "<leader>CR", "<cmd>CopilotChatRefactor<cr>",  desc = "Refactor code" },
            { "<leader>Cs", "<cmd>CopilotChatSummarize<cr>", desc = "Summarize text" },
        },
    },
}
