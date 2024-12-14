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
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    enabled = false,
    config = function()
      require 'lualine'.setup {
        options = {
          icons_enabled = true,
          component_separators = { left = '', right = '|' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { 'NvimTree' },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_x = { 'filetype' },
          lualine_y = {},
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },

}
