return {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    keys = {
        { '<leader><Tab>', function() require('nvim-tree.api').tree.change_root_to_node() end, desc = "Swap root to selected directory" }
    },
    config = function()
        require('nvim-tree').setup {
            disable_netrw = true,
            sync_root_with_cwd = true,
            hijack_cursor = true,
            view = {
                relativenumber = true,
            },
            renderer = {
                root_folder_label = function(path)
                    path = path:gsub('\\', '/')

                    -- Split the path into segments using forward slash as the delimiter
                    local segments = {}
                    for segment in path:gmatch '[^/]+' do
                        table.insert(segments, segment)
                    end

                    -- Return the last segment (folder)
                    return '/' .. segments[#segments]
                end,
            },
        }
    end,
}
