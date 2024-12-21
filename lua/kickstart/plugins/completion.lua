return {
  'saghen/blink.cmp',
  dependencies = {
    -- Snippet Engine
    { 'L3MON4D3/LuaSnip', version = 'v2.*' },

    -- Sources
    'kristijanhusak/vim-dadbod-completion',
    'giuxtaposition/blink-cmp-copilot',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',

    -- Additional snippets
    'solidjs-community/solid-snippets',
  },
  version = 'v0.*',
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
      ['<C-k>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-space>'] = {},
      ['<C-x>'] = { 'hide' },
      ['<C-t>'] = { 'show' },
    },
    snippets = {
      expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
      active = function(filter)
        if filter and filter.direction then
          return require('luasnip').jumpable(filter.direction)
        end
        return require('luasnip').in_snippet()
      end,
      jump = function(direction) require('luasnip').jump(direction) end,
    },
    sources = {
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
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
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
        },
      },
      default = { 'copilot', 'lsp', 'path', 'buffer', 'dadbod', 'snippets' },
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
