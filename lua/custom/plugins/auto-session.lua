return {
    'rmagatti/auto-session',
    lazy = false,
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        suppress_dirs = { '~/', '~/repos', '~/Downloads', '/' },
        save_extra_cmds = {
            function()
                local commands = {}
                for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.b[bufnr].pinned == 1 then
                        local filename = vim.api.nvim_buf_get_name(bufnr)
                        if filename ~= "" then
                            -- Generate command to set buffer variable directly
                            local escaped_filename = vim.fn.escape(filename, "'\\")
                            table.insert(commands, "call setbufvar(bufnr('" .. escaped_filename .. "'), 'pinned', 1)")
                        end
                    end
                end
                if vim.tbl_isempty(commands) then
                    return nil
                end
                return commands
            end
        }
    },
    init = function()
        -- recommended by auto-session
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end
}
