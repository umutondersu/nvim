---@module 'snacks'
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        quickfile = { enabled = true },
        words = { enabled = true },
        indent = { enabled = true, animate = { enabled = false } },
        styles = {
            notification = {
                wo = { wrap = true } -- Wrap notifications
            }
        },
        scope = { enabled = true }, -- Jumps: ]i [i textobjects: ii(inner scope) ai(full scope)
        picker = {
            matcher = {
                frecency = true,
            },
        },
    },
    keys = {
        { "<leader>e",  function() Snacks.explorer.open() end,           desc = "Toggle File Explorer" },
        { "<leader>St", function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
        { "<leader>Ss", function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
        { "<leader>nh", function() Snacks.notifier.show_history() end,   desc = "Notification History" },
        { "<leader>nd", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
        { "<A-c>",      function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
        { "<leader>rf", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
        { "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
        { "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
        { "<leader>gx", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
        -- LazyGit
        { "<leader>gF", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
        { "<leader>gg", function() Snacks.lazygit.open() end,            desc = "Lazygit" },
        { "<leader>gL", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
        -- [[ Picker ]]
        -- Search
        { "<leader>sf", function() Snacks.picker.files() end,            desc = "Files" },
        {
            "<leader>sb",
            function()
                Snacks.picker.buffers({
                    -- I always want my buffers picker to start in normal mode
                    on_show = function()
                        vim.cmd.stopinsert()
                    end,
                    win = {
                        input = {
                            keys = {
                                ["d"] = "bufdelete",
                            },
                        },
                        list = { keys = { ["d"] = "bufdelete" } },
                    },
                    -- In case you want to override the layout for this keymap
                    -- layout = "ivy",
                })
            end,
            desc = "Buffers"
        },
        { "<leader>sc", function() Snacks.picker.commands() end,           desc = "Commands" },
        { "<leader>sC", function() Snacks.picker.command_history() end,    desc = "Command History" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end,        desc = "Diagnostics" },
        ---@diagnostic disable-next-line: undefined-field
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostics on Buffer" },
        { "<leader>sp", function() Snacks.picker.projects() end,           desc = "Projects" },
        ---@diagnostic disable-next-line: undefined-field
        { "<leader>st", function() Snacks.picker.todo_comments() end,      desc = "Todo Comments" },
        { "<leader>sr", function() Snacks.picker.resume() end,             desc = "Resume" },
        -- Grep
        { "<leader>s/", function() Snacks.picker.lines() end,              desc = "Grep Buffer Lines" },
        { "<leader>sG", function() Snacks.picker.grep_buffers() end,       desc = "Grep Open Buffers" },
        { "<leader>sg", function() Snacks.picker.grep() end,               desc = "Grep" },
        { "<leader>sw", function() Snacks.picker.grep_word() end,          desc = "Grep Visual selection or word", mode = { "n", "x" } },
        -- Git
        -- - `<Tab>`: stages or unstages the currently selected file
        -- - `<cr>`: opens the currently selected file
        {
            "<leader>gb",
            function()
                Snacks.picker.git_branches({
                    layout = "select",
                })
            end,
            desc = "Git Branches"
        },
        { "<leader>gf",  function() Snacks.picker.git_files() end,  desc = "Find Git Files" },
        { "<leader>gs",  function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<leader>gS",  function() Snacks.picker.git_stash() end,  desc = "Git Stash" },
        { "<leader>gl",  function() Snacks.picker.git_log() end,    desc = "Git Log" },
        -- Neovim
        { "<leader>snh", function() Snacks.picker.help() end,       desc = "Help" },
        {
            "<leader>snk",
            function()
                Snacks.picker.keymaps({
                    layout = 'vertical',
                })
            end,
            desc = "Keymaps"
        },
        {
            "<leader>snf",
            function()
                Snacks.picker.files({
                    cwd = vim.fn.stdpath('config')[0]
                })
            end,
            desc = "Files"
        },
        {
            "<leader>snn",
            desc = "News",
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.6,
                    wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3, },
                })
            end,
        }
    },
    init = function()
        -- Terminal keymaps
        local function t_keymap(lhs, rhs, opts)
            vim.keymap.set('t', lhs, rhs, opts)
        end

        t_keymap('<c-h>', '<Cmd>wincmd h<CR>')
        t_keymap('<c-k>', '<Cmd>wincmd k<CR>')
        t_keymap('<c-j>', '<Cmd>wincmd j<CR>')
        t_keymap('<c-l>', '<Cmd>wincmd l<CR>')
        t_keymap('<c-w>', [[<C-\><C-n><C-w>]])
        t_keymap('<esc>', [[<C-\><C-n>]])

        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.animate():map("<leader>ua")

                -- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                -- Snacks.toggle.line_number():map("<leader>ul")
                -- Snacks.toggle.treesitter():map("<leader>uT")
                -- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
            end,
        })

        -- New command to create a snacks window for running lazydocker like lazygit
        vim.api.nvim_create_user_command("Docker", function()
            Snacks.win({
                style = 'lazygit',
                file = nil,
                buf = vim.api.nvim_create_buf(false, true), -- Create a scratch buffer for the terminal
                on_win = function(self)
                    vim.fn.termopen("lazydocker", {
                        on_exit = function() -- Close the window when the process exits
                            self:close()
                        end,
                    })
                    vim.cmd("startinsert") -- Enter insert mode for terminal
                end,
            })
        end, { nargs = 0 })
    end,
}
