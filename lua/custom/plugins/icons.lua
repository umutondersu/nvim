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
            ["go.mod"] = {
                icon = "󰟓",
                color = "#519bba",
                name = "go.mod",
            },
        },
        override_by_extension = {
            ["toml"] = {
                icon = "",
                name = "Gear"
            },
        },
    },
}
