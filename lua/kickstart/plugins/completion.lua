return {
  'saghen/blink.cmp',
  dependencies = {
    -- Integrate Nvim-cmp completion sources
    { 'saghen/blink.compat', version = '*',   lazy = true, opts = {} },

    -- Sources
    'kristijanhusak/vim-dadbod-completion',
    'folke/lazydev.nvim',
    'milanglacier/minuet-ai.nvim',

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
      cmdline = {
        preset = 'none',
        ['<C-a>'] = { 'select_and_accept' },
        ['<C-x>'] = { 'show', 'hide' },
        ['<Tab>'] = { 'select_next', },
        ['<S-Tab>'] = { 'select_prev', },
        ['<Space>'] = { function(cmp)
          return cmp.accept({
            callback = function()
              local keys = vim.api.nvim_replace_termcodes('<Space>', true, true, true)
              vim.api.nvim_feedkeys(keys, 'n', true)
            end
          })
        end, 'fallback' },
      }
    },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'minuet', 'lsp', 'path', 'buffer', 'dadbod', 'snippets', 'lazydev', 'avante_commands', 'avante_files', 'avante_mentions' },
      providers = {
        minuet = {
          name = 'minuet',
          module = 'minuet.blink',
          async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Minuet"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end
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
        avante_commands = { name = "avante_commands", module = "blink.compat.source", score_offset = 90, opts = {} },
        avante_files = { name = "avante_files", module = "blink.compat.source", score_offset = 100, opts = {} },
        avante_mentions = { name = "avante_mentions", module = "blink.compat.source", score_offset = 1000, opts = {} }
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
      kind_icons = {
        Minuet = ''
      }
    },
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" }
}
