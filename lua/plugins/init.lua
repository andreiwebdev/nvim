return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "scss",
        "json",
        "vue",
        "twig",
        "php",
        "javascript",
        "typescript",
        "tsx",
      },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      max_lines = 3,
      -- draws a visible rule under the sticky header so it doesn't blend
      -- into the code beneath it under a transparent/blurred terminal
      separator = "─",
    },
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP References (Trouble)" },
    },
    opts = {},
  },

  {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "ClaudeCode",
    keys = {
      { "<C-,>", desc = "Toggle Claude Code" },
      { "<leader>cC", desc = "Claude Code (--continue)" },
      { "<leader>cV", desc = "Claude Code (--verbose)" },
    },
    config = function()
      require("claude-code").setup {
        refresh = {
          enable = true,
          updatetime = 100,
          timer_interval = 1000,
          show_notifications = true,
        },
      }
    end,
  },
}
