local cmp = {
  'saghen/blink.cmp',
  dependencies = {
    -- Integrate Nvim-cmp completion sources
    { 'saghen/blink.compat', version = '*',   lazy = true, opts = {} },

    -- Sources
    'kristijanhusak/vim-dadbod-completion',
    {
      'fang2hou/blink-copilot',
      dependencies = 'zbirenbaum/copilot.lua'
    },
    {
      'Kaiser-Yang/blink-cmp-git',
      enabled = vim.fn.executable 'gh' == 1,
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      "Yu-Leo/cmp-go-pkgs",
      enabled = vim.fn.executable 'go' == 1,
      init = function()
        vim.api.nvim_create_autocmd({ "LspAttach" }, {
          pattern = { "*.go" },
          callback = function(args)
            require("cmp_go_pkgs").init_items(args)
          end,
        })
      end
    },

    -- Snippet Engine
    { 'L3MON4D3/LuaSnip',    version = 'v2.*' },

    -- Snippets
    'rafamadriz/friendly-snippets',
    'solidjs-community/solid-snippets',

    -- Visual
    { 'xzbdmw/colorful-menu.nvim', opts = {} }
  },
  version = '*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      menu = {
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        },
        border = 'rounded',
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = 'rounded'
        }
      }
    },
    keymap = {
      preset = 'default',
      ['<C-a>'] = { 'select_and_accept' },
      ['<C-x>'] = { 'show', 'hide' },
      ['<C-k>'] = { 'show_documentation', 'hide_documentation' },
      ['<C-space>'] = {},
      ['<Up>'] = {},
      ['<Down>'] = {},
    },
    cmdline = {
      keymap = {
        preset = 'cmdline',
        ['<C-a>'] = { 'select_and_accept' },
        ['<C-x>'] = { 'show', 'hide' },
        ['<C-space>'] = {},
      }
    },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'copilot', 'lsp', 'path', 'buffer', 'dadbod', 'snippets', 'lazydev', 'avante_commands', 'avante_files', 'avante_mentions', 'go_pkgs' },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          async = true,
          opts = {
            max_completions = 3,
            max_attempts = 4,
          }
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
        },
        go_pkgs = {
          name = "go_pkgs",
          module = "blink.compat.source",
          score_offset = 1000,
          enabled = function()
            return vim.fn.executable 'go' == 1
          end,
          opts = {}
        },
        avante_commands = { name = "avante_commands", module = "blink.compat.source", score_offset = 90, opts = {} },
        avante_files = { name = "avante_files", module = "blink.compat.source", score_offset = 100, opts = {} },
        avante_mentions = { name = "avante_mentions", module = "blink.compat.source", score_offset = 1000, opts = {} }
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
      kind_icons = require('kickstart.icons').kinds
    },
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" }
}
if vim.fn.executable 'gh' == 1 then
  cmp.opts.sources.providers.git = {
    module = 'blink-cmp-git',
    name = 'Git',
    async = true,
    enabled = function()
      return vim.tbl_contains({ 'octo', 'gitcommit', 'markdown' }, vim.bo.filetype)
    end,
    opts = {},
  }
  ---@diagnostic disable-next-line
  table.insert(cmp.opts.sources.default, 'git')
end
return cmp
