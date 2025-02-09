return {
    'rmagatti/auto-session',
    lazy = false,
    opts = {
        suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    },
    init = function()
        -- recommended by auto-session
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end
}
