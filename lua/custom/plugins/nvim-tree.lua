return {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
        {
            'nvim-tree/nvim-web-devicons',
            config = function()
                require('nvim-web-devicons').setup {
                    strict = true,
                    default = true,
                    override_by_filename = {
                        ['package.json'] = {
                            icon = '',
                            color = '#326da8',
                            name = 'json',
                        },
                    },
                }
            end,
        },
    },
    keys = {
        {
            '<leader><Tab>',
            function()
                require('nvim-tree.api').tree.change_root_to_node()
            end,
            desc = 'Swap root to selected directory',
        },
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
                indent_markers = {
                    enable = true,
                },
            },
        }
        -- [[ Configure nvim-tree ]]
        -- Disable netrw for nvim-tree and autoclose
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- auto close
        vim.api.nvim_create_autocmd('QuitPre', {
            callback = function()
                local tree_wins = {}
                local floating_wins = {}
                local wins = vim.api.nvim_list_wins()
                for _, w in ipairs(wins) do
                    local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
                    if bufname:match 'NvimTree_' ~= nil then
                        table.insert(tree_wins, w)
                    end
                    if vim.api.nvim_win_get_config(w).relative ~= '' then
                        table.insert(floating_wins, w)
                    end
                end
                if 1 == #wins - #floating_wins - #tree_wins then
                    -- Should quit, so we close all invalid windows.
                    for _, w in ipairs(tree_wins) do
                        vim.api.nvim_win_close(w, true)
                    end
                end
            end,
        })
    end,
}
