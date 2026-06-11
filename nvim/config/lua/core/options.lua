vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

if not vim.keymap or not vim.keymap.set then
  local keymap_callbacks = {}
  local next_keymap_callback_id = 0

  _G.__codex_keymap_run = function(id)
    local callback = keymap_callbacks[id]
    if callback then
      return callback()
    end
  end

  vim.keymap = vim.keymap or {}
  vim.keymap.set = function(mode, lhs, rhs, opts)
    opts = opts or {}

    local modes = type(mode) == 'table' and mode or { mode }
    local map_opts = {
      noremap = opts.remap ~= true,
      silent = opts.silent or false,
      expr = opts.expr or false,
      nowait = opts.nowait or false,
    }

    for _, m in ipairs(modes) do
      local map_rhs = rhs
      if type(rhs) == 'function' then
        next_keymap_callback_id = next_keymap_callback_id + 1
        keymap_callbacks[next_keymap_callback_id] = rhs
        map_rhs = string.format(':lua __codex_keymap_run(%d)<CR>', next_keymap_callback_id)
      end

      if opts.buffer then
        vim.api.nvim_buf_set_keymap(opts.buffer, m, lhs, map_rhs, map_opts)
      else
        vim.api.nvim_set_keymap(m, lhs, map_rhs, map_opts)
      end
    end
  end
end

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.clipboard = 'unnamedplus' -- Use system clipboard for yank/paste

vim.cmd [[ set noswapfile ]]
vim.cmd [[ set termguicolors ]]

--Line numbers
vim.wo.number = true
