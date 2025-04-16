return {
    'rmagatti/auto-session',
    event = 'VimEnter',
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    },
    init = function()
        -- recommended by auto-session
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end
}
