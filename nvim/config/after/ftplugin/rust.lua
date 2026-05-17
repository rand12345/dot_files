local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<Leader>k", function() vim.cmd.RustLsp("hover_actions") end, { buffer = bufnr, desc = "Rust hover actions" })
vim.keymap.set("n", "<Leader>a", function() vim.cmd.RustLsp("codeAction") end, { buffer = bufnr, desc = "Rust code action" })
vim.keymap.set("n", "<Leader>d", function() vim.cmd.RustLsp("debuggables") end, { buffer = bufnr, desc = "Rust debuggables" })
vim.keymap.set("n", "<Leader>r", function() vim.cmd.RustLsp("runnables") end, { buffer = bufnr, desc = "Rust runnables" })

vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = bufnr,
  callback = function() vim.lsp.buf.format({ async = false }) end,
})
