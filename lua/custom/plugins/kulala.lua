return {
    'mistweaverco/kulala.nvim',
    opts = {},
    ft = 'http',
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
        }
        vim.api.nvim_create_user_command("Kulala", function(opts)
            local kulala = require("kulala")
            local subcommand = commands[opts.args]

            if subcommand and kulala[subcommand] then
                kulala[subcommand]()
            else
                print("Unknown Kulala command: " .. opts.args)
            end
        end, {
            nargs = 1,
            complete = function()
                return vim.tbl_keys(commands) -- Auto-completion from command keys
            end,
        })
    end
}
