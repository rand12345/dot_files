local api = require("Comment.api")
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)

-- Keep normal-mode mappings explicit. For visual mode, capture the active mode
-- before leaving selection so Comment.nvim receives a valid motion.
vim.keymap.set("n", "gc", api.call("toggle.linewise", "g@"), { expr = true, desc = "Comment toggle linewise" })
vim.keymap.set("n", "gb", api.call("toggle.blockwise", "g@"), { expr = true, desc = "Comment toggle blockwise" })
vim.keymap.set("n", "gcc", api.call("toggle.linewise.current", "g@$"), { expr = true, desc = "Comment toggle current line" })
vim.keymap.set("n", "gbc", api.call("toggle.blockwise.current", "g@$"), { expr = true, desc = "Comment toggle current block" })

vim.keymap.set("x", "gc", function()
  local motion = vim.fn.mode()
  vim.api.nvim_feedkeys(esc, "nx", false)
  api.toggle.linewise(motion)
end, { desc = "Comment toggle linewise (visual)" })

vim.keymap.set("x", "gb", function()
  local motion = vim.fn.mode()
  vim.api.nvim_feedkeys(esc, "nx", false)
  api.toggle.blockwise(motion)
end, { desc = "Comment toggle blockwise (visual)" })

vim.keymap.set("n", "gco", api.insert.linewise.below, { desc = "Comment insert below" })
vim.keymap.set("n", "gcO", api.insert.linewise.above, { desc = "Comment insert above" })
vim.keymap.set("n", "gcA", api.insert.linewise.eol, { desc = "Comment insert end of line" })
