local options = {
  -- This is a new table for defining custom formatter commands
  formatters = {
    -- Override the default 'prettier' definition
    prettier = {
      -- Use the local prettier binary
      command = "prettier",
      -- Only load the Vue plugin for actual .vue files: forcing it
      -- unconditionally broke every other filetype routed through this
      -- formatter (js/ts/css/html/json/yaml/md), since prettier hard-fails
      -- when a --plugin can't be resolved, even if that file has nothing
      -- to do with Vue.
      args = function(_, ctx)
        local args = { "--stdin-filepath", "$FILENAME" }
        if vim.endswith(ctx.filename, ".vue") then
          vim.list_extend(args, { "--plugin", "prettier-plugin-vue" })
        end
        return args
      end,
    },
  },

  formatters_by_ft = {
    lua = { "stylua" },

    -- twig (djlint) and php (php_cs_fixer) are intentionally left
    -- unformatted for now: djlint needs Python >=3.10 (system has 3.9.6)
    -- and php_cs_fixer needs a local `php` binary, neither of which is
    -- available on this machine. Revisit once either is in place.

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
