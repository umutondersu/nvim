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
        input = { enabled = true },
        image = { enabled = true, doc = { enabled = true, inline = false, float = true } },
        dashboard = { enabled = true },
        picker = {
            matcher = { frecency = true },
            win = {
                input = {
                    keys = {
                        ["<C-s>"] = { "flash", mode = { "n", "i" } },
                        ["<C-y>"] = { "yank", mode = { "n", "i" } },
                        ["s"] = { "flash" },
                    },
                },
            },
            actions = {
                flash = function(picker)
                    require("flash").jump({
                        pattern = "^",
                        label = { after = { 0, 0 } },
                        search = {
                            mode = "search",
                            exclude = {
                                function(win)
                                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                                end,
                            },
                        },
                        action = function(match)
                            local idx = picker.list:row2idx(match.pos[1])
                            picker.list:_move(idx, true, true)
                        end,
                    })
                end,
                yank = function(_, item)
                    if not item then return end
                    local text = item.text
                    if item.text then
                        vim.fn.setreg("+", text)
                    else
                        vim.notify("No text to yank", "warn")
                    end
                end
            },
            layouts = {
                widedefault = {
                    layout = {
                        box = "horizontal",
                        width = 0.9,
                        min_width = 200,
                        height = 0.9,
                        {
                            box = "vertical",
                            border = "rounded",
                            title = "{title} {live} {flags}",
                            { win = "input", height = 1,     border = "bottom" },
                            { win = "list",  border = "none" },
                        },
                        { win = "preview", title = "{preview}", border = "rounded", width = 0.7 },
                    },
                }
            }
        }
    },
    keys = {
        { "<leader>e",  function() Snacks.explorer.open() end,           desc = "Toggle File Explorer" },
        { "<leader>Ss", function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
        { "<leader>SS", function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
        { "<leader>uN", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
        { "<M-n>",      function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
        { "<A-c>",      function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
        { "<leader>rf", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
        { "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
        { "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",           mode = { "n", "t" } },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",           mode = { "n", "t" } },
        { "<leader>gx", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
        -- [[ Picker ]]
        -- Search
        {
            "<leader>un",
            function()
                Snacks.picker.notifications({
                    confirm = function(self, item, _)
                        if item.text then
                            vim.fn.setreg("+", item.text)
                        else
                            vim.notify("No text to yank", "warn")
                        end
                        self:close()
                    end
                })
            end,
            desc = "Notifications"
        },
        { "<leader>sf", function() Snacks.picker.files() end, desc = "Files" },
        { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
        {
            "<leader><space>",
            function()
                Snacks.picker.buffers({
                    win = {
                        input = {
                            keys = {
                                ["d"] = "bufdelete",
                                ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
                                ["<m-c>"] = { "bufdelete", mode = { "n", "i" } },
                            },
                        },
                        list = { keys = { ["d"] = "bufdelete" } },
                    },
                })
            end,
            desc = "Find Buffers"
        },
        { "<leader>sD", function() Snacks.picker.diagnostics() end,   desc = "Workspace Diagnostics" },
        {
            "<leader>sd",
            function() Snacks.picker.diagnostics_buffer({ layout = 'ivy_split' }) end,
            desc = "Diagnostics"
        },
        {
            "<leader>sp",
            function()
                Snacks.picker.pickers({
                    layout = 'select',
                })
            end,
            desc = "Pickers"
        },
        {
            "<leader>sj",
            function()
                Snacks.picker.files {
                    ft = { "jpg", "jpeg", "png", "webp" },
                    confirm = function(self, item, _)
                        self:close()
                        require("img-clip").paste_image({}, "./" .. item.file)
                    end,
                    layout = 'widedefault',
                }
            end,
            desc = 'Pictures'
        },
        { "<leader>sP", function() Snacks.picker.projects() end,      desc = "Projects" },
        { "<leader>su", function() Snacks.picker.undo() end,          desc = "Undo Tree" },
        ---@diagnostic disable-next-line: undefined-field
        { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo Comments" },
        { "<leader>sr", function() Snacks.picker.resume() end,        desc = "Resume" },
        { "<leader>s.", function() Snacks.picker.recent() end,        desc = "Recent Files" },
        -- Grep
        { "<leader>/",  function() Snacks.picker.lines() end,         desc = "Grep Lines" },
        { "<leader>sG", function() Snacks.picker.grep_buffers() end,  desc = "Grep Open Buffers" },
        { "<leader>sg", function() Snacks.picker.grep() end,          desc = "Grep" },
        { "<leader>sw", function() Snacks.picker.grep_word() end,     desc = "Grep Word" },
        { "<leader>g",  function() Snacks.picker.grep_word() end,     desc = "Grep Search",          mode = "x" },
        -- Git
        { "<leader>gf", function() Snacks.picker.git_files() end,     desc = "Git Files" },
        { "<leader>gd", function() Snacks.picker.git_diff() end,      desc = "Git Diff" },
        {
            "<leader>gs",
            -- - `<Tab>`: stages or unstages the currently selected file
            -- - `<cr>`: opens the currently selected file
            -- - `<C-d>`: discard the changes on currently selected file
            function()
                Snacks.picker.git_status({
                    layout = 'widedefault',
                    focus = 'list',
                    win = {
                        input = {
                            keys = {
                                ["<Tab>"] = { "git_stage", mode = { "n", "i" } },
                                ["d"] = { "git_discard", mode = { "n", "i" } },
                                ["<c-d>"] = { "git_discard", mode = { "n", "i" } },
                            },
                        },
                    },
                    actions = {
                        git_discard = function(picker, item)
                            if not item then return end

                            local file = item.file or item.text
                            if not file then return end

                            local current_idx = picker.list.cursor

                            if item.status and (item.status:match("^%?") or item.status:match("^A")) then
                                vim.fn.system({ "git", "clean", "-fd", file })
                                if item.status:match("^A") then
                                    vim.fn.system({ "git", "reset", "HEAD", file })
                                end
                            else
                                vim.fn.system({ "git", "checkout", "HEAD", "--", file })
                            end

                            picker:find({
                                refresh = true,
                                on_done = function()
                                    local new_count = picker:count()
                                    if new_count > 0 then
                                        local target_idx = math.min(current_idx, new_count)
                                        picker.list:view(target_idx)
                                    end
                                end
                            })
                            vim.notify("Discarded changes for: " .. file, 'warn')
                        end,
                    },
                })
            end,
            desc = "Git Status"
        },
        -- Neovim
        { "<leader>snh", function() Snacks.picker.help() end,      desc = "Help" },
        {
            "<leader>snk",
            function() Snacks.picker.keymaps({ layout = 'vertical' }) end,
            desc = "Keymaps"
        },
        {
            "<leader>snf",
            function()
                Snacks.picker.files({
                    cwd = vim.fn.stdpath("config") --[[@as string]]
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
        },
        -- LazyGit
        { "<leader>gh",  function() Snacks.lazygit.log_file() end, desc = "Git File History" },
        { "<leader>gg",  function() Snacks.lazygit.open() end,     desc = "Lazygit" },
        { "<leader>gl",  function() Snacks.lazygit.log() end,      desc = "Git Log" }
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
                Snacks.toggle.animate():map("<leader>ua")
                Snacks.toggle.line_number():map("<leader>uL")
                -- Toggle Inlay Hints
                vim.api.nvim_create_autocmd('LspAttach', {
                    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = false }),
                    callback = function(event)
                        local client = vim.lsp.get_client_by_id(event.data.client_id)
                        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                            local function toggle_inlay_hints()
                                local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
                                require("which-key").add({
                                    {
                                        '<leader>uh',
                                        function()
                                            vim.lsp.inlay_hint.enable(not enabled)
                                            toggle_inlay_hints()
                                        end,
                                        desc = (enabled and 'Disable' or 'Enable') .. ' Inlay Hints',
                                        icon = {
                                            icon = enabled and '' or '',
                                            color = enabled and 'green' or 'yellow'
                                        }
                                    }
                                })
                            end
                            toggle_inlay_hints()
                        end
                    end
                })

                -- Snacks.toggle.inlay_hints():map("<leader>uh")
                -- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                -- Snacks.toggle.treesitter():map("<leader>uT")
                -- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
            end,
        })

        -- New command to create a snacks window for running lazydocker like lazygit
        vim.api.nvim_create_user_command("Docker", function()
            Snacks.terminal('lazydocker')
        end, { nargs = 0 })
    end,
    dependencies = {
        { 'folke/todo-comments.nvim', lazy = true, dependencies = { 'nvim-lua/plenary.nvim' }, opts = {} },
        'folke/flash.nvim'
    },
}
