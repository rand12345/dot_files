-- Navigate vim panes
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', { desc = 'Move to window above' })
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', { desc = 'Move to window below' })
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', { desc = 'Move to window left' })
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', { desc = 'Move to window right' })

-- General
vim.keymap.set('n', '<Space>h', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Rust LSP (buffer-local overrides live in after/ftplugin/rust.lua)
vim.keymap.set('n', '<Space>f', function() vim.lsp.buf.format({ async = false }) end, { desc = 'Format file' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Show references' })

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

