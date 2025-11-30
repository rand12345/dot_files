-- Navigate vim panes
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', { desc = 'Move to window above' })
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', { desc = 'Move to window below' })
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', { desc = 'Move to window left' })
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', { desc = 'Move to window right' })

-- General
vim.keymap.set('n', '<Space>h', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Rust LSP
vim.keymap.set('n', '<Space>a', ':RustLsp codeAction<CR>', { desc = 'Rust code actions' })
vim.keymap.set('n', '<Space>f', ':RustFmt<CR>', { desc = 'Format Rust file' })
vim.keymap.set('n', '<Space>e', ':RustLsp explainError<CR>', { desc = 'Explain Rust error' })
vim.keymap.set('n', '<Space>ha', ':RustLsp hover actions<CR>', { desc = 'Rust hover actions' })
vim.keymap.set('n', 'gd', ':RustLsp definition<CR>', { desc = 'Go to definition' })
vim.keymap.set('n', 'gr', ':RustLsp references<CR>', { desc = 'Show references' })
vim.keymap.set('n', '<Space>r', ':RustLsp runnables<CR>', { desc = 'Run Rust code' })

-- Testing
vim.keymap.set('n', '<Space>t', ':TestNearest<CR>', { desc = 'Run nearest test' })
vim.keymap.set('n', '<Space>T', ':TestFile<CR>', { desc = 'Run file tests' })

-- Telescope
vim.keymap.set('n', '<Space>ld', ':Telescope diagnostics<CR>', { desc = 'List diagnostics' })
vim.keymap.set('n', '<Space>ls', ':Telescope lsp_document_symbols<CR>', { desc = 'List document symbols' })

-- Diagnostics
vim.keymap.set('n', '<Space>d', function()
  vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
end, { desc = 'Toggle lsp_lines' })

