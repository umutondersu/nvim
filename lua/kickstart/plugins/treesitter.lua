return {
    -- Treesitter is a new parser generator tool that we can
    -- use in Neovim to power faster and more accurate
    -- syntax highlighting.
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = function()
            local TS = require("nvim-treesitter")
            if not TS.get_installed then
                vim.notify("Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter` **main** branch.",
                    vim.log.levels.ERROR)
                return
            end
            if not vim.fn.executable('tree-sitter') then
                vim.notify("tree-sitter CLI is not installed!", vim.log.levels.ERROR)
                return
            end
        end,
        event = "VeryLazy",
        cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
        opts_extend = { "ensure_installed" },
        opts = {
            indent = { enable = true },
            highlight = { enable = true },
            folds = { enable = true },
            ensure_installed = {
                'html',
                'css',
                'scss',
                'c',
                'cpp',
                'go',
                'lua',
                'python',
                'fish',
                'tsx',
                'javascript',
                'typescript',
                'vimdoc',
                'vim',
                'bash',
                'http',
                'json',
                'sql',
                'markdown',
                'markdown_inline', -- noice.nvim
                'regex',           -- noice.nvim
                'diff',
                'gitcommit'
            },
        },
        config = function(_, opts)
            local TS = require("nvim-treesitter")
            setmetatable(require("nvim-treesitter.install"), {
                __newindex = function(_, k)
                    if k == "compilers" then
                        vim.schedule(function()
                            vim.notify(
                                [[Setting custom compilers for `nvim-treesitter` is no longer supported.
                                For more info, see:,
                                - [compilers](https://docs.rs/cc/latest/cc/#compile-time-requirements)]]
                            )
                        end)
                    end
                end,
            })

            -- some quick sanity checks
            if not TS.get_installed then
                return vim.notify("Please use `:Lazy` and update `nvim-treesitter`", vim.log.levels.ERROR)
            elseif type(opts.ensure_installed) ~= "table" then
                return vim.notify("`nvim-treesitter` opts.ensure_installed must be a table", vim.log.levels.ERROR)
            end

            local treesitter = {}
            treesitter._installed = nil
            treesitter._queries = {}
            local function get_installed(update)
                if update then
                    treesitter._installed, treesitter._queries = {}, {}
                    for _, lang in ipairs(TS.get_installed("parsers")) do
                        treesitter._installed[lang] = true
                    end
                end
                return treesitter._installed or {}
            end
            local function have_query(lang, query)
                local key = lang .. ":" .. query
                if treesitter._queries[key] == nil then
                    treesitter._queries[key] = vim.treesitter.query.get(lang, query) ~= nil
                end
                return treesitter._queries[key]
            end
            local function have(what, query)
                what = what or vim.api.nvim_get_current_buf()
                what = type(what) == "number" and vim.bo[what].filetype or what
                local lang = vim.treesitter.language.get_lang(what)
                if lang == nil or get_installed()[lang] == nil then
                    return false
                end
                if query and not have_query(lang, query) then
                    return false
                end
                return true
            end

            TS.setup(opts)
            get_installed(true)
            local install = vim.tbl_filter(function(lang)
                return not have(lang)
            end, opts.ensure_installed or {})
            if #install > 0 then
                TS.install(install, { summary = true }):await(function()
                    get_installed(true)
                end)
            end
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("my_treesitter", { clear = true }),
                callback = function(ev)
                    local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)
                    if not have(ft) then
                        return
                    end
                    local function enabled(feat, query)
                        local f = opts[feat] or {}
                        return f.enable ~= false
                            and not (type(f.disable) == "table" and vim.tbl_contains(f.disable, lang))
                            and have(ft, query)
                    end
                    if enabled("highlight", "highlights") then
                        pcall(vim.treesitter.start, ev.buf)
                    end
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = "VeryLazy",
        opts = {
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                -- LazyVim extention to create buffer-local keymaps
                keys = {
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
                },
            },
        },
        config = function(_, opts)
            local TS = require("nvim-treesitter-textobjects")
            if not TS.setup then
                vim.notify("Please use `:Lazy` and update `nvim-treesitter`", vim.log.levels.ERROR)
                return
            end
            TS.setup(opts)

            local function attach(buf)
                ---@type table<string, table<string, string>>
                local moves = vim.tbl_get(opts, "move", "keys") or {}

                for method, keymaps in pairs(moves) do
                    for key, query in pairs(keymaps) do
                        local queries = type(query) == "table" and query or { query }
                        local parts = {}
                        for _, q in ipairs(queries) do
                            local part = q:gsub("@", ""):gsub("%..*", "")
                            part = part:sub(1, 1):upper() .. part:sub(2)
                            table.insert(parts, part)
                        end
                        local desc = table.concat(parts, " or ")
                        desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
                        desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
                        vim.keymap.set({ "n", "x", "o" }, key, function()
                            if vim.wo.diff and key:find("[cC]") then
                                return vim.cmd("normal! " .. key)
                            end
                            require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
                        end, {
                            buffer = buf,
                            desc = desc,
                            silent = true,
                        })
                    end
                end
            end

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("lazyvim_treesitter_textobjects", { clear = true }),
                callback = function(ev)
                    attach(ev.buf)
                end,
            })
            vim.tbl_map(attach, vim.api.nvim_list_bufs())
        end,
    },
    -- Automatically add closing tags for HTML and JSX
    {
        "windwp/nvim-ts-autotag",
        ft = {
            'astro',
            'glimmer',
            'handlebars',
            'html',
            'javascript',
            'javascriptreact',
            'liquid',
            'markdown',
            'php',
            'rescript',
            'svelte',
            'typescriptreact',
            'twig',
            'typescript',
            'vue',
            'xml',
        },
        opts = {},
    },
}