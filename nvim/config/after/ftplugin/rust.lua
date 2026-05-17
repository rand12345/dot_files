local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<Space>k", function() vim.cmd.RustLsp({ "hover", "actions" }) end, { buffer = bufnr, desc = "Rust hover actions" })
vim.keymap.set("n", "<Space>a", function() vim.cmd.RustLsp("codeAction") end, { buffer = bufnr, desc = "Rust code action" })
vim.keymap.set("n", "<Space>d", function() vim.cmd.RustLsp("debuggables") end, { buffer = bufnr, desc = "Rust debuggables" })
vim.keymap.set("n", "<Space>r", function() vim.cmd.RustLsp("runnables") end, { buffer = bufnr, desc = "Rust runnables" })
vim.keymap.set("n", "<Space>e", function() vim.cmd.RustLsp("explainError") end, { buffer = bufnr, desc = "Rust explain error" })

-- Explicitly override <space>f so it always uses LSP format, not rust.vim
vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format({ async = false }) end, { buffer = bufnr, desc = "Format (rustfmt)" })

vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = bufnr,
  callback = function() vim.lsp.buf.format({ async = false }) end,
})
