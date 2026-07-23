require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        styles = {
          comments = { "italic" },
        },
      })
      vim.o.termguicolors = true
      vim.o.background = "dark"
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = function()
      return {
        pre_hook = function(ctx)
          local ok, cstr = pcall(require("Comment.ft").calculate, ctx)
          if ok and cstr then
            return cstr
          end
          return vim.bo.commentstring
        end,
      }
    end,
  },
  "mattn/emmet-vim",
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "ellisonleao/gruvbox.nvim",
  "dracula/vim",
  "nvim-lualine/lualine.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = function()
      if vim.fn.executable("tree-sitter") == 1 then
        vim.cmd("TSUpdate")
      end
    end,
    config = function()
      local languages = {
        "c",
        "html",
        "lua",
        "markdown",
        "markdown_inline",
        "ruby",
        "rust",
        "vim",
        "vimdoc",
      }

      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- The main branch is the supported nvim-treesitter implementation for
      -- Neovim 0.12. Keep its parsers in the normal site directory; loading
      -- the former cache directory can select stale, incompatible parsers.
      if vim.fn.executable("tree-sitter") == 1 then
        require("nvim-treesitter").install(languages)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
        pattern = languages,
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  "vim-test/vim-test",
  "lewis6991/gitsigns.nvim",
  "preservim/vimux",
  "christoomey/vim-tmux-navigator",
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "stevearc/oil.nvim",
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      require('lsp_lines').setup()
    end,
  },
  "mfussenegger/nvim-dap",
  {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      { "<Space>ff", "<cmd>FzfLua files<cr>",     desc = "Find files" },
      { "<Space>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
      { "<Space>fb", "<cmd>FzfLua buffers<cr>",   desc = "Buffers" },
      { "<Space>fr", "<cmd>FzfLua oldfiles<cr>",  desc = "Recent files" },
    },
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^9',
    lazy = false,
    init = function()
      vim.g.rustfmt_autosave = 0
    end,
  },
  {
    'SuperBo/fugit2.nvim',
    opts = function()
      local libgit2
      if vim.fn.has("mac") == 1 then
        libgit2 = "/opt/homebrew/lib/libgit2.dylib"
      else
        libgit2 = vim.fn.system("pkg-config --variable=libdir libgit2"):gsub("%s+$", "") .. "/libgit2.so"
      end
      return { width = 100, libgit2_path = libgit2 }
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
      {
        'chrisgrieser/nvim-tinygit',
        dependencies = { 'stevearc/dressing.nvim' }
      },
    },
    cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph' },
    keys = {
      { '<Space>F', mode = 'n', '<cmd>Fugit2<cr>' }
    }
  },
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",
  "github/copilot.vim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
})
