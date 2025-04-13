return {
    'nvim-java/nvim-java',
    ft = 'java',
    config = function()
        require('java').setup()
    end
}
