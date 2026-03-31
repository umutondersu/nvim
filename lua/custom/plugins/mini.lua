return {
    -- Collection of various small independent plugins/modules
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    {
        "nvim-mini/mini.ai",
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({ -- code block
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),       -- class
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },           -- tags
                    d = { "%f[%d]%d+" },                                                          -- digits
                    e = {                                                                         -- Word with case
                        { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
                        "^().*()$",
                    },
                    u = ai.gen_spec.function_call(),                           -- u for "Usage"
                    U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
                },
            }
        end,
        config = function(_, opts)
            require("mini.ai").setup(opts)
        end,
    },
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - gsaw)  - [G]enerously [S]urround [A]round [W]ord [)]Paren
    -- - gsd'   - [G]racefully [S]urround [D]elete [']quotes
    -- - gsc)'  - [G]loriously [S]urround [C]hange [)] [']
    {
        'nvim-mini/mini.surround',
        version = false,
        event = 'VeryLazy',
        opts = {
            mappings = {
                add = 'gs',             -- Add surrounding in Normal and Visual modes
                delete = 'gsd',         -- Delete surrounding
                find = 'gsf',           -- Find surrounding (to the right)
                find_left = 'gsF',      -- Find surrounding (to the left)
                highlight = 'gsh',      -- Highlight surrounding
                replace = 'gsc',        -- Replace surrounding
                update_n_lines = 'gsn', -- Update `n_lines`

                suffix_last = 'p',      -- Suffix to search with "prev" method
                suffix_next = 'n',      -- Suffix to search with "next" method
            },
        }
    },
    -- Move lines easily in visual and normal mode
    {
        'nvim-mini/mini.move',
        version = false,
        event = 'VeryLazy',
        opts = {
            mappings = {
                -- Move visual selection in Visual mode
                left = 'H',
                right = 'L',
                down = 'J',
                up = 'K',
                -- Move current line in Normal mode
                line_left = '',
                line_right = '',
                line_down = '<M-j>',
                line_up = '<M-k>',
            },
        }
    },
    {
        'nvim-mini/mini.pairs',
        version = false,
        event = 'InsertEnter',
        opts = {}
    },
    {
        'nvim-mini/mini.bracketed',
        version = false,
        event = 'VeryLazy',
        opts = {}
    },
    { 'nvim-mini/mini.icons', version = false, opts = {} },
    -- ... and there is more!
    --  Check out: https://github.com/nvim-mini/mini.nvim
}
