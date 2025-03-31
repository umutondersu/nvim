---@param component any
---@param text string
---@param hl_group? string
---@return string
local function format(component, text, hl_group)
    text = text:gsub("%%", "%%%%")
    if not hl_group or hl_group == "" then
        return text
    end
    ---@type table<string, string>
    component.hl_cache = component.hl_cache or {}
    local lualine_hl_group = component.hl_cache[hl_group]
    if not lualine_hl_group then
        local utils = require("lualine.utils.utils")
        ---@type string[]
        local gui = vim.tbl_filter(function(x)
            return x
        end, {
            utils.extract_highlight_colors(hl_group, "bold") and "bold",
            utils.extract_highlight_colors(hl_group, "italic") and "italic",
        })

        lualine_hl_group = component:create_hl({
            fg = utils.extract_highlight_colors(hl_group, "fg"),
            gui = #gui > 0 and table.concat(gui, ",") or nil,
        }, "LV_" .. hl_group) --[[@as string]]
        component.hl_cache[hl_group] = lualine_hl_group
    end
    return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
end

---@param opts? { icon?:string}
local function root_dir(opts)
    opts = vim.tbl_extend("force", {
        icon = "󱉭 ",
        color = function()
            return { fg = Snacks.util.color("Special") }
        end,
    }, opts or {})

    local function get()
        local cwd = vim.fn.getcwd()
        local name = vim.fn.fnamemodify(cwd, ":t")

        return cwd and name
    end

    return {
        function()
            return (opts.icon and opts.icon .. " ") .. get()
        end,
        cond = function()
            return type(get()) == "string"
        end,
        color = opts.color,
    }
end

---@param opts? {relative: "cwd"|"root", modified_hl: string?, directory_hl: string?, filename_hl: string?, modified_sign: string?, readonly_icon: string?, length: number?}
local function pretty_path(opts)
    opts = vim.tbl_extend("force", {
        relative = "cwd",
        modified_hl = "MatchParen",
        directory_hl = "",
        filename_hl = "Bold",
        modified_sign = "",
        readonly_icon = " 󰌾 ",
        length = 3,
    }, opts or {})

    return function(self)
        local path = vim.fn.expand("%:p") --[[@as string]]

        if path == "" then
            return ""
        end

        path = vim.fn.fnamemodify(path, ":p")
        local root = vim.fn.getcwd()
        local cwd = vim.fn.getcwd()

        if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
            path = path:sub(#cwd + 2)
        elseif path:find(root, 1, true) == 1 then
            path = path:sub(#root + 2)
        end

        local sep = package.config:sub(1, 1)
        local parts = vim.split(path, "[\\/]")

        if opts.length == 0 then
            parts = parts
        elseif #parts > opts.length then
            parts = { parts[1], "…", unpack(parts, #parts - opts.length + 2, #parts) }
        end

        if opts.modified_hl and vim.bo.modified then
            parts[#parts] = parts[#parts] .. opts.modified_sign
            parts[#parts] = format(self, parts[#parts], opts.modified_hl)
        else
            parts[#parts] = format(self, parts[#parts], opts.filename_hl)
        end

        local dir = ""
        if #parts > 1 then
            dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
            dir = format(self, dir .. sep, opts.directory_hl)
        end

        local readonly = ""
        if vim.bo.readonly then
            readonly = format(self, opts.readonly_icon, opts.modified_hl)
        end
        return dir .. parts[#parts] .. readonly
    end
end

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            -- set an empty statusline till lualine loads
            vim.o.statusline = " "
        else
            -- hide the statusline on the starter page
            vim.o.laststatus = 0
        end
    end,
    opts = function()
        -- PERF: we don't need this lualine require madness 🤷
        local lualine_require = require("lualine_require")
        lualine_require.require = require

        local icons = require('kickstart.icons')

        local opts = {
            options = {
                theme = "auto",
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },

                lualine_c = {
                    root_dir(),
                    {
                        "diagnostics",
                        symbols = {
                            error = icons.diagnostics.Error,
                            warn = icons.diagnostics.Warn,
                            info = icons.diagnostics.Info,
                            hint = icons.diagnostics.Hint,
                        },
                    },
                    { "filetype",   icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { pretty_path() },
                },
                lualine_x = {
                    ---@module 'snacks'
                    Snacks.profiler.status(),
                    {
                        ---@diagnostic disable-next-line: undefined-field
                        function() return require("noice").api.status.command.get() end,
                        ---@diagnostic disable-next-line: undefined-field
                        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                        color = function() return { fg = Snacks.util.color("Statement") } end,
                    },
                    {
                        ---@diagnostic disable-next-line: undefined-field
                        function() return require("noice").api.status.mode.get() end,
                        ---@diagnostic disable-next-line: undefined-field
                        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                        color = function() return { fg = Snacks.util.color("Constant") } end,
                    },
                    {
                        function() return "  " .. require("dap").status() end,
                        cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                        color = function() return { fg = Snacks.util.color("Debug") } end,
                    },
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = function() return { fg = Snacks.util.color("Special") } end,
                    },
                    {
                        "diff",
                        symbols = {
                            added = icons.git.added,
                            modified = icons.git.modified,
                            removed = icons.git.removed,
                        },
                        source = function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if gitsigns then
                                return {
                                    added = gitsigns.added,
                                    modified = gitsigns.changed,
                                    removed = gitsigns.removed,
                                }
                            end
                        end,
                    },
                },
                lualine_y = {},
                lualine_z = {},
            },
        }

        return opts
    end,
}
