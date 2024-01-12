return {
    "CRAG666/code_runner.nvim",
    config = function()
        local function jsruntime()
            if vim.fn.has('win32') == 1
            then
                return "node run"
            else
                return "bun run"
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
            },
        })
    end
}

