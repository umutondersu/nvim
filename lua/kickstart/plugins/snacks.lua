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
                        ["<M-s>"] = { "flash", mode = { "n", "i" } },
                        ["<C-y>"] = { "yank", mode = { "n", "i" } },
                        ["<C-s>"] = { "flash_select", mode = { "n", "i" } },
                        ["S"] = { "flash" },
                        ["s"] = { "flash_select" },
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
                flash_select = function(picker)
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
                            picker:action('confirm')
                        end,
                    })
                end,
                yank = function(_, item)
                    vim.fn.setreg("+", item.text or '')
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
        { "<leader>q",  function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
        { "<leader>rf", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
        { "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
        { "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",           mode = { "n", "t" } },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",           mode = { "n", "t" } },
        -- [[ Picker ]]
        -- Search
        {
            "<leader>un",
            function()
                Snacks.picker.notifications({
                    on_show = function()
                        vim.cmd.stopinsert()
                    end,
                    confirm = function(self, item, _)
                        vim.fn.setreg("+", item.text or '')
                        self:close()
                    end
                })
            end,
            desc = "Notifications"
        },
        {
            "<leader>sb",
            function()
                Snacks.picker.buffers({
                    -- on_show = function()
                    -- vim.cmd.stopinsert()
                    --     vim.schedule(function()
                    --         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-s>', true, false, true), 'm', false)
                    --     end)
                    -- end,
                    format = function(item, picker)
                        local default_format = Snacks.picker.format.buffer(item, picker)
                        -- Check if buffer is pinned
                        local bufnr = item.buf
                        if bufnr > 0 and vim.b[bufnr].pinned == 1 then
                            table.insert(default_format, { "📌", "DiagnosticHint" })
                        end
                        return default_format
                    end,
                    win = {
                        input = {
                            keys = {
                                ["d"] = "bufdelete",
                                ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
                                ["x"] = "pin",
                                ["<c-x>"] = { "pin", mode = { "n", "i" } },
                            },
                        },
                    },
                    actions = {
                        pin = function(picker, item)
                            local bufnr = item.buf
                            if bufnr <= 0 then
                                return
                            end
                            -- Toggle the pinned state
                            if vim.b[bufnr].pinned == 1 then
                                vim.b[bufnr].pinned = nil
                            else
                                vim.b[bufnr].pinned = 1
                            end

                            picker:find({
                                refresh = true,
                                on_done = function()
                                    picker.list:_move(item.idx, true, true)
                                end
                            })
                        end
                    }
                })
            end,
            desc = "Buffers"
        },
        {
            "<leader>sd",
            function()
                Snacks.picker.diagnostics_buffer({
                    layout = 'ivy_split',
                    on_show = function()
                        vim.cmd.stopinsert()
                    end,
                })
            end,
            desc = "Diagnostics"
        },
        {
            "<leader>sP",
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
        {
            "<leader>su",
            function()
                Snacks.picker.undo({
                    layout = 'widedefault',
                    on_show = function()
                        vim.cmd.stopinsert()
                    end,
                })
            end,
            desc = "Undo Tree"
        },
        {
            "<leader>st",
            function()
                ---@diagnostic disable-next-line: undefined-field
                Snacks.picker.todo_comments({
                    on_show = function() vim.cmd.stopinsert() end,
                })
            end,
            desc = "Todo Comments"
        },
        {
            "<leader>si",
            function() Snacks.picker.icons({ layout = 'select' }) end,
            desc = "Icons"
        },
        { "<leader>sf", function() Snacks.picker.files() end,        desc = "Files" },
        { "<leader>sD", function() Snacks.picker.diagnostics() end,  desc = "Workspace Diagnostics" },
        { "<leader>sp", function() Snacks.picker.pickers() end,      desc = "Pickers" },
        { "<leader>sr", function() Snacks.picker.resume() end,       desc = "Resume" },
        { "<leader>s.", function() Snacks.picker.recent() end,       desc = "Recent Files" },
        -- Grep
        { "<leader>/",  function() Snacks.picker.lines() end,        desc = "Grep Lines" },
        { "<leader>sG", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
        { "<leader>sg", function() Snacks.picker.grep() end,         desc = "Grep" },
        { "<leader>sw", function() Snacks.picker.grep_word() end,    desc = "Grep Word" },
        { "<leader>g",  function() Snacks.picker.grep_word() end,    desc = "Grep Search",          mode = "x" },
        -- Git
        { "<leader>gx", function() Snacks.gitbrowse() end,           desc = "Browse" },
        { "<leader>gf", function() Snacks.picker.git_files() end,    desc = "Files" },
        {
            "<leader>gd",
            -- - `<Tab>`: stages the selected hunk
            -- - `<cr>`: opens the selected hunk
            -- - `<C-d>`: discards the selected hunk
            function()
                Snacks.picker.git_diff({
                    layout = 'widedefault',
                    on_show = function()
                        vim.cmd.stopinsert()
                    end,
                    win = {
                        input = {
                            keys = {
                                ["<C-d>"] = { "git_discard_hunk", mode = { "n", "i" } },
                                ["d"] = { "git_discard_hunk" },
                                ["<Tab>"] = { "git_stage_hunk", mode = { "n", "i" } },
                            },
                        },
                    },
                    actions = {
                        git_discard_hunk = function(picker, item)
                            local file = item.file
                            local patch = item.diff
                            local tmpfile = vim.fn.tempname()
                            vim.fn.writefile(vim.split(patch, "\n"), tmpfile)

                            vim.fn.system(string.format("git apply -R %s", tmpfile))
                            os.remove(tmpfile)
                            if vim.v.shell_error ~= 0 then
                                vim.notify("Failed to discard hunk", vim.log.levels.ERROR)
                                return
                            end

                            picker:find({
                                refresh = true,
                                on_done = function()
                                    picker.list:view(item.idx)
                                end,
                            })
                            vim.notify("Discarded hunk in: " .. vim.fn.fnamemodify(file, ":t"), vim.log.levels.WARN)
                        end,
                        git_stage_hunk = function(picker, item)
                            local file = item.file
                            local patch = item.diff

                            local tmpfile = vim.fn.tempname()
                            vim.fn.writefile(vim.split(patch, "\n"), tmpfile)
                            vim.fn.system(string.format("git apply --cached %s", tmpfile))
                            os.remove(tmpfile)
                            if vim.v.shell_error ~= 0 then
                                vim.notify("Failed to stage hunk", vim.log.levels.ERROR)
                                return
                            end

                            picker:find({
                                refresh = true,
                                on_done = function()
                                    picker.list:view(item.idx)
                                end,
                            })
                            vim.notify("Staged hunk in: " .. vim.fn.fnamemodify(file, ":t"), vim.log.levels.INFO)
                        end
                    },
                })
            end,
            desc = "Diff"
        },
        {
            "<leader>gs",
            -- - `<Tab>`: stages or unstages the currently selected file
            -- - `<cr>`: opens the currently selected file
            -- - `<C-d>`: discard the changes on currently selected file
            function()
                Snacks.picker.git_status({
                    layout = 'widedefault',
                    on_show = function()
                        vim.cmd.stopinsert()
                    end,
                    win = {
                        input = {
                            keys = {
                                ["d"] = { "git_discard", },
                                ["<c-d>"] = { "git_discard", mode = { "n", "i" } },
                            },
                        },
                    },
                    actions = {
                        git_discard = function(picker, item)
                            local file = item.file

                            if item.status:match("^%?") or item.status:match("^A") then
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
                                    picker.list:view(item.idx)
                                end
                            })
                            vim.notify("Discarded changes for: " .. vim.fn.fnamemodify(file, ":t"), 'warn')
                        end,
                    },
                })
            end,
            desc = "Status"
        },
        -- Neovim
        { "<leader>snh", function() Snacks.picker.help() end,      desc = "Help" },
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
                    cwd = vim.fn.stdpath("config"), --[[@as string]]
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
        { "<leader>gh",  function() Snacks.lazygit.log_file() end, desc = "File History" },
        { "<leader>gg",  function() Snacks.lazygit.open() end,     desc = "Lazygit" },
        { "<leader>gl",  function() Snacks.lazygit.log() end,      desc = "Log" }
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
        { 'folke/todo-comments.nvim', lazy = true, dependencies = 'nvim-lua/plenary.nvim', opts = {} }
    },
}
