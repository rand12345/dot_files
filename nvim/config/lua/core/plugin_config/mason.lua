require("mason").setup()

-- Auto-install codelldb for Rust DAP; rust-analyzer comes from rustup
require("mason-registry").refresh(function()
  local registry = require("mason-registry")
  for _, name in ipairs({ "codelldb" }) do
    local ok, pkg = pcall(registry.get_package, name)
    if ok and not pkg:is_installed() then
      pkg:install()
    end
  end
end)
