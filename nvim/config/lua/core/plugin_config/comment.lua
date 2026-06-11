local api = require("Comment.api")
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

-- Comment.nvim's default visual mappings rely on <CMD>, which is brittle on
-- older Neovim builds. Override them with explicit Lua callbacks.
vim.keymap.set("n", "gc", api.call("toggle.linewise", "g@"), { expr = true, desc = "Comment toggle linewise" })
vim.keymap.set("n", "gb", api.call("toggle.blockwise", "g@"), { expr = true, desc = "Comment toggle blockwise" })
vim.keymap.set("n", "gcc", api.call("toggle.linewise.current", "g@$"), { expr = true, desc = "Comment toggle current line" })
vim.keymap.set("n", "gbc", api.call("toggle.blockwise.current", "g@$"), { expr = true, desc = "Comment toggle current block" })

vim.keymap.set("x", "gc", function()
  vim.api.nvim_feedkeys(esc, "nx", false)
  api.toggle.linewise(vim.fn.visualmode())
end, { desc = "Comment toggle linewise (visual)" })

vim.keymap.set("x", "gb", function()
  vim.api.nvim_feedkeys(esc, "nx", false)
  api.toggle.blockwise(vim.fn.visualmode())
end, { desc = "Comment toggle blockwise (visual)" })

vim.keymap.set("n", "gco", api.insert.linewise.below, { desc = "Comment insert below" })
vim.keymap.set("n", "gcO", api.insert.linewise.above, { desc = "Comment insert above" })
vim.keymap.set("n", "gcA", api.insert.linewise.eol, { desc = "Comment insert end of line" })
