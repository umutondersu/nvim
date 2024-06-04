return {
    "CRAG666/code_runner.nvim",
    config = function()
        local function jsruntime()
            if require("lib").command_exists('bun')
            then
                return "bun run"
            else
                return "node run"
            end
        end
        require('code_runner').setup({
            filetype = {
                java = {
                    "cd $dir &&",
                    "javac $fileName &&",
                    "java $fileNameWithoutExt"
                },
                python = "python3 -u",
                typescript = jsruntime(),
                rust = {
                    "cd $dir &&",
                    "rustc $fileName &&",
                    "$dir/$fileNameWithoutExt"
                },
                c = function(...)
                    local c_base = {
                        "cd $dir &&",
                        "gcc $fileName -o",
                        "/tmp/$fileNameWithoutExt",
                    }
                    local c_exec = {
                        "&& /tmp/$fileNameWithoutExt &&",
                        "rm /tmp/$fileNameWithoutExt",
                    }
                    vim.ui.input({ prompt = "Add more args:" }, function(input)
                        c_base[4] = input
                        vim.print(vim.tbl_extend("force", c_base, c_exec))
                        require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
                    end)
                end,
            },
        })
    end
}
