return {
    'rmagatti/auto-session',
    lazy = false,
    opts = {
        suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        session_lens = { load_on_setup = false }
    },
    init = function()
        -- recommended by auto-session
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end
}
