-- Disable built-in rust.vim format-on-save; we use LSP (rustaceanvim) instead
vim.g.rustfmt_autosave = 0
vim.g.rustfmt_command = nil

local ok, mason_registry = pcall(require, "mason-registry")

local adapter
if ok then
  local codelldb_ok, codelldb = pcall(function()
    return mason_registry.get_package("codelldb")
  end)
  if codelldb_ok and codelldb:is_installed() then
    local ext = codelldb:get_install_path() .. "/extension/"
    local liblldb_ext = vim.fn.has("mac") == 1 and ".dylib" or ".so"
    adapter = require("rustaceanvim.config").get_codelldb_adapter(
      ext .. "adapter/codelldb",
      ext .. "lldb/lib/liblldb" .. liblldb_ext
    )
  end
end

vim.g.rustaceanvim = {
  server = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<Leader>k", function() vim.cmd.RustLsp("hover_actions") end, { buffer = bufnr })
      vim.keymap.set("n", "<Leader>a", function() vim.cmd.RustLsp("code_action") end, { buffer = bufnr })
      vim.keymap.set("n", "<Leader>d", function() vim.cmd.RustLsp("debuggables") end, { buffer = bufnr })
      -- format-on-save via rustfmt
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function() vim.lsp.buf.format({ async = false }) end,
      })
    end,
  },
  tools = {
    hover_actions = { auto_focus = true },
  },
  dap = adapter and { adapter = adapter } or {},
}
