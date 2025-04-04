-- [[Language specific plugins]]
local ts_ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }
return {
  -- Typescript
  { 'dmmulroy/tsc.nvim',                 ft = ts_ft, opts = {} },
  { 'dmmulroy/ts-error-translator.nvim', ft = ts_ft },
  {
    'pmizio/typescript-tools.nvim',
    ft = ts_ft,
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        }
      },
    },
  },
  -- C#
  {
    'Hoffs/omnisharp-extended-lsp.nvim',
    ft = 'cs',
    enabled = vim.fn.executable 'dotnet' == 1
  },
  -- Java
  {
    'nvim-java/nvim-java',
    ft = 'java',
    enabled = vim.fn.executable 'java' == 1
  },
  -- Lua
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  -- Go
  {
    'olexsmir/gopher.nvim',
    enabled = vim.fn.executable 'go' == 1,
    ft = 'go',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    build = function() vim.cmd.GoInstallDeps() end,
    opts = {},
  },
  {
    'fredrikaverpil/godoc.nvim',
    enabled = vim.fn.executable 'go' == 1,
    ft = 'go',
    version = '*',
    dependencies = { 'folke/snacks.nvim' },
    build = 'go install github.com/lotusirous/gostdsym/stdsym@latest',
    cmd = { 'GoDoc' },
    opts = { picker = { type = 'snacks' } }
  }
}
