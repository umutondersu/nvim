return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  {                                        -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- For Tsserver
      'dmmulroy/ts-error-translator.nvim',

      -- For LSP actions preview
      'aznhe21/actions-preview.nvim',

      -- Preview for go to methods
      { 'rmagatti/goto-preview', opts = {}, event = 'VeryLazy', },

      -- Populates project-wide lsp diagnostcs
      'artemave/workspace-diagnostics.nvim',

      --Omnisharp Extensions
      'Hoffs/omnisharp-extended-lsp.nvim',

    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')


          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('gy', require('telescope.builtin').lsp_type_definitions, '[G]oto T[Y]pe [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>sD', require('telescope.builtin').lsp_document_symbols, '[S]earch [D]ocument Symbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>sW', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]earch [W]orkspace Symbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>o', require("actions-preview").code_actions, 'Code action', { 'n', 'x' })
          -- map('<leader>a', vim.lsp.buf.code_action, 'Code [A]ction')

          --This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Peek Keymaps
          map('gpd', function() require("goto-preview").goto_preview_definition({}) end, '[P]review [D]efinition')
          map('gpy', function() require("goto-preview").goto_preview_type_definition({}) end,
            '[P]review t[Y]pe [D]efinition')
          map('gpi', function() require("goto-preview").goto_preview_implementation({}) end, '[P]review [I]mplementation')
          map('gpD', function() require("goto-preview").goto_preview_declaration({}) end, '[P]review [D]eclaration')

          -- Omnisharp Extended LSP
          if client and client.name == "omnisharp" then
            map('gd', function() require('omnisharp_extended').lsp_definition() end, '[G]oto [D]efinition')
            map('gy', function() require('omnisharp_extended').lsp_type_definition() end, '[G]oto T[Y]pe [D]efinition')
            map('gr', function() require('omnisharp_extended').telescope_lsp_references() end, '[G]oto [R]eferences')
            map('gI', function() require('omnisharp_extended').lsp_implementation() end, '[G]oto [I]mplementation')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- rust_analyzer = {},
        -- html = { filetypes = { 'html', 'twig', 'hbs'} },

        pyright = {},

        omnisharp = {},

        ts_ls = {
          settings = {
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
          },
        },

        lua_ls = {
          settings = {
            Lua = {
              hint = { enable = true },
              telemetry = { enable = false },
              diagnostics = { disable = { 'missing-fields' } },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },

      }


      if vim.fn.executable('go') == 1 then
        servers.gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        }
      end

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- Formatters
        'black',
        'isort',
        'prettier',
        'prettierd',
        -- Linters
        'eslint_d',
        'flake8',
      })

      if vim.fn.executable('dotnet') == 1 then
        vim.list_extend(ensure_installed, {
          'csharpier'
        })
      end

      if vim.fn.executable('go') == 1 then
        vim.list_extend(ensure_installed, {
          'golangci-lint',
          'gofumpt',
          'goimports',
          -- Gopher.nvim
          'gomodifytags',
          'gotests',
          'iferr',
          'impl',
        })
      end

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            server.on_attach = function(client, bufnr)
              require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
            end
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
