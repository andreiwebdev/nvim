local options = {
  -- This is a new table for defining custom formatter commands
  formatters = {
    -- Override the default 'prettier' definition
    prettier = {
      -- Use the local prettier binary
      command = "prettier",
      -- Add the arguments that explicitly load the Vue plugin
      args = {
        "--stdin-filepath",
        "$FILENAME",
        -- This is the crucial part that loads the parser for Vue templates
        "--plugin",
        "prettier-plugin-vue",
      },
    },
  },

  formatters_by_ft = {
    lua = { "stylua" },
    twig = { "djlint" },
    php = { "php_cs_fixer" },

    -- We revert these to only use the *customized* 'prettier'
    -- (We don't need prettierd if it was causing problems)
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },

    -- The fix is applied here, pointing to the custom 'prettier' formatter
    vue = { "prettier" },
  },

  -- Keep the default format-on-save configuration enabled (optional but recommended)
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
