return {
    'nvim-tree/nvim-web-devicons',
    opts = {
        strict = true,
        default = true,
        override_by_filename = {
            ['package.json'] = {
                icon = '',
                color = '#326da8',
                name = 'json',
            },
        },
        override_by_extension = {
            ["toml"] = {
                icon = "",
                name = "Gear"
            }
        },
    },
}

