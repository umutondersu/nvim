return {
    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
        config = function()
            -- ensure basic parser are installed
            local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim',
                'vimdoc', 'regex' }
            require('nvim-treesitter').install(parsers)

            ---@param buf integer
            ---@param language string
            local function treesitter_try_attach(buf, language)
                -- check if parser exists and load it
                if not vim.treesitter.language.add(language) then return end
                -- enables syntax highlighting and other treesitter features
                vim.treesitter.start(buf, language)
                -- enables treesitter based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end

            local available_parsers = require('nvim-treesitter').get_available()
            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('treesitter-attach', { clear = true }),
                callback = function(args)
                    local buf, filetype = args.buf, args.match

                    local language = vim.treesitter.language.get_lang(filetype)
                    if not language then return end

                    local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

                    if vim.tbl_contains(installed_parsers, language) then
                        -- enable the parser if it is installed
                        treesitter_try_attach(buf, language)
                    elseif vim.tbl_contains(available_parsers, language) then
                        -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
                        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
                    else
                        -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
                        treesitter_try_attach(buf, language)
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
