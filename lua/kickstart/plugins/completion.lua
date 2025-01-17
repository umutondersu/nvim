return {
  'saghen/blink.cmp',
  dependencies = {
    -- Integrate Nvim-cmp completion sources
    { 'saghen/blink.compat', version = '*',   lazy = true, opts = {} },

    -- Sources
    'kristijanhusak/vim-dadbod-completion',
    'giuxtaposition/blink-cmp-copilot',
    'folke/lazydev.nvim',

    -- Snippet Engine
    { 'L3MON4D3/LuaSnip',    version = 'v2.*' },

    -- Snippets
    'rafamadriz/friendly-snippets',
    'solidjs-community/solid-snippets',
  },
  version = '*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      menu = {
        draw = {
          columns = { { "label", "label_description" }, { "kind_icon", "kind", gap = 1 } },
        },
        border = 'rounded',
        winhighlight =
        "Normal:None,BlinkCmpMenu:None,BlinkCmpMenuBorder:None,BlinkCmpMenuSelection:PmenuSel,BlinkCmpScrollBarThumb:PmenuThumb,BlinkCmpScrollBarGutter:PmenuSbar,BlinkCmpLabel:None,BlinkCmpLabelDeprecated:NonText,BlinkCmpLabelMatch:None,BlinkCmpLabelDetail:NonText,BlinkCmpLabelDescription:NonText,BlinkCmpKind:Special,BlinkCmpSource:NonText,BlinkCmpGhostText:NonText,BlinkCmpDoc:NormalFloat,BlinkCmpDocBorder:NormalFloat,BlinkCmpDocSeparator:NormalFloat,BlinkCmpDocCursorLine:Visual,BlinkCmpSignatureHelp:NormalFloat,BlinkCmpSignatureHelpBorder:NormalFloat,BlinkCmpSignatureHelpActiveParameter:LspSignatureActiveParameter",
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
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = -1,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
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
        avante_files = { name = "avante_commands", module = "blink.compat.source", score_offset = 100, opts = {} },
        avante_mentions = { name = "avante_mentions", module = "blink.compat.source", score_offset = 1000, opts = {} }
      },
      default = { 'copilot', 'lsp', 'path', 'buffer', 'dadbod', 'snippets', 'lazydev', 'avante_commands', 'avante_files', 'avante_mentions' },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
      kind_icons = {
        Copilot = "",
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',

        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',

        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',

        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',

        Keyword = '󰻾',
        Constant = '󰏿',

        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      },
    },

  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" }
}
