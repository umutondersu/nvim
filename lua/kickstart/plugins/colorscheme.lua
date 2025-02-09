return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      local Transparent = true
      if Transparent then
        require("tokyonight").setup({
          transparent = true,
          styles = {
            sidebars = "transparent",
            floats = "transparent",
          },
          on_highlights = function(hl)
            local LineNrHighlight = "#898da0"
            hl.LineNr = {
              fg = LineNrHighlight,
            }
            hl.LineNrAbove = {
              fg = LineNrHighlight,
            }
            hl.LineNrBelow = {
              fg = LineNrHighlight,
            }
          end,
        })
        vim.api.nvim_create_autocmd('ColorScheme', {
          callback = vim.schedule_wrap(function()
            vim.cmd('hi BufferTabpageFill guibg=none')
            vim.cmd('hi BufferOffset guibg=none')
          end),
          group = vim.api.nvim_create_augroup('foo', {}),
        })
      else
        require("tokyonight").setup()
        vim.api.nvim_create_autocmd('ColorScheme', {
          callback = vim.schedule_wrap(function()
            vim.cmd('hi BufferTabpageFill guibg=none')
          end),
          group = vim.api.nvim_create_augroup('foo', {}),
        })
      end
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    enabled = false,
    opts = {
      options = {
        component_separators = { left = '', right = '|' },
        section_separators = { left = '', right = '' },
      },
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
      sections = {
        lualine_a = {},
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          {
            'buffers',
            symbols = {
              modified = ' ●', -- Text to show when the buffer is modified
              alternate_file = '', -- Text to show to identify the alternate file
              directory = '', -- Text to show when the buffer is a directory
            },
          }
        },
        -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }
  },

}
