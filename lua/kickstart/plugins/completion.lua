return {
  'saghen/blink.cmp',
  dependencies = {
    -- Integrate Nvim-cmp completion sources
    { 'saghen/blink.compat', version = '*',   lazy = true, opts = {} },

    -- Sources
    'kristijanhusak/vim-dadbod-completion',
    'Kaiser-Yang/blink-cmp-avante',
    'disrupted/blink-cmp-conventional-commits',
    {
      'fang2hou/blink-copilot',
      dependencies = {
        'zbirenbaum/copilot.lua',
        build = ':Copilot auth',
        cmd = 'Copilot',
        event = 'InsertEnter',
        opts = {
          panel = { enabled = false },
          suggestion = { enabled = false },
          filetypes = {
            help = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ['.'] = false,
          },
          copilot_node_command = 'node',
          server_opts_overrides = {},
        }
      },

    },
    {
      'Kaiser-Yang/blink-cmp-git',
      dependencies = 'nvim-lua/plenary.nvim'
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
      default = { 'copilot', 'lsp', 'path', 'buffer', 'dadbod', 'snippets', 'lazydev', 'avante', 'go_pkgs', 'git', 'markdown', 'conventional_commits' },
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
        git = {
          module = 'blink-cmp-git',
          name = 'Git',
          async = true,
          enabled = function()
            return vim.tbl_contains({ 'octo', 'gitcommit', 'markdown' }, vim.bo.filetype) and vim.fn.executable 'gh' == 1
          end,
          opts = {},
        },
        conventional_commits = {
          name = 'Conventional Commits',
          module = 'blink-cmp-conventional-commits',
          enabled = function()
            return vim.bo.filetype == 'gitcommit'
          end,
          opts = {},
        },
        markdown = {
          name = 'RenderMarkdown',
          module = 'render-markdown.integ.blink',
          fallbacks = { 'lsp' },
        },
        avante = {
          module = 'blink-cmp-avante',
          name = 'Avante',
          opts = {}
        },
        go_pkgs = {
          name = "go_pkgs",
          module = "blink.compat.source",
          enabled = function()
            return vim.fn.executable 'go' == 1
          end,
          opts = {}
        },
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
      kind_icons = require('kickstart.icons').kind_icons
    },
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" }
}
