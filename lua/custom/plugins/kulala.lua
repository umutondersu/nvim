return {
    'mistweaverco/kulala.nvim',
    opts = {},
    ft = { 'http', 'rest' },
    dependencies = {
        {
            "Redoxahmii/json-to-types.nvim",
            build = "sh install.sh npm",
            ft = "json",
            cmd = 'ConvertJSONtoLang'
        }
    },
    init = function()
        local commands = {
            Run = "run",
            RunAll = "run_all",
            Replay = "replay",
            Inspect = "inspect",
            ShowStats = "show_stats",
            Scratchpad = "scratchpad",
            Copy = "copy",
            FromCurl = "from_curl",
            Close = "close",
            ToggleView = "toggle_view",
            Search = "search",
            JumpPrev = "jump_prev",
            JumpNext = "jump_next",
            TypeDef = "TypeDef"
        }
        vim.api.nvim_create_user_command("Kulala", function(opts)
            local kulala = require("kulala")
            local args = vim.split(opts.args, " ")
            local subcommand = commands[args[1]]

            if subcommand == "TypeDef" then
                if not args[2] then
                    vim.notify('need to specify language')
                    return
                end
                require("kulala.api").on("after_next_request", function(data)
                    local filename = "kulala.json"
                    local file = io.open(filename, "w")
                    if not file then
                        print("Error: Failed to open file for writing")
                        return
                    end
                    file:write(data.body)
                    file:close()
                    vim.cmd("edit " .. filename)
                    local buf = vim.api.nvim_get_current_buf()
                    vim.cmd("ConvertJSONtoLang " .. args[2])

                    vim.api.nvim_buf_delete(buf, { force = true })
                    os.remove(filename)
                end)
                require("kulala").run()
            elseif subcommand and kulala[subcommand] then
                kulala[subcommand]()
            else
                print("Unknown Kulala command: " .. opts.args)
            end
        end, {
            nargs = "+",
            complete = function(_, cmdline, _)
                local parts = vim.split(cmdline, " ")
                if #parts == 2 then
                    return vim.tbl_keys(commands) -- Auto-completion for subcommands
                elseif #parts == 3 and parts[2] == "TypeDef" then
                    return {                      -- Auto-completion for languages
                        "typescript",
                        "javascript",
                        "python",
                        "csharp",
                        "go",
                        "rust",
                        "php",
                        "ruby",
                        "swift",
                        "kotlin",
                        "cpp",
                        "cjson",
                        "cr",
                        "dart",
                        "elixir",
                        "elm",
                        "flow",
                        "haskell",
                        "java",
                        "javascript-prop-types",
                        "objc",
                        "pike",
                        "scala3",
                        "Smithy",
                        "typescript-zod",
                        "typescript-effect-schema"
                    }
                end
                return {}
            end,
        })
    end

}
