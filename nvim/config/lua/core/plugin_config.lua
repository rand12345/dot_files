-- Catppuccin theme
require('catppuccin').setup({ flavour = 'mocha' })
vim.cmd.colorscheme 'catppuccin'

-- Nvim-tree
require('nvim-tree').setup()

-- Lualine
require('lualine').setup({
  options = { theme = 'catppuccin' },
})

-- Treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'rust', 'lua' },
  highlight = { enable = true },
  indent = { enable = true },
})

-- Gitsigns
require('gitsigns').setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
  },
})

-- Oil.nvim
require('oil').setup()

-- LSP diagnostics
vim.diagnostic.config({
  virtual_text = { prefix = '●', source = 'if_many', spacing = 4 },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
local signs = { Error = '✘', Warn = '▲', Hint = '➤', Info = 'ℹ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-e>'] = cmp.mapping.abort(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

-- Mason (only for tool installation, no LSP setup)
require('mason').setup()

-- rustaceanvim
vim.g.rustaceanvim = {
  server = {
    cmd = { 'rust-analyzer' }, -- Ensure rust-analyzer is in PATH
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = { command = 'clippy' },
        inlayHints = { enable = true, parameterHints = true, typeHints = true },
      },
    },
  },
}

-- lsp_lines.nvim
require('lsp_lines').setup()
