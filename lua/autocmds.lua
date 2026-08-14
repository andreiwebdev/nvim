require "nvchad.autocmds"

-- Reload buffers automatically when files change on disk (git checkouts,
-- Claude Code edits, formatters, etc.) instead of showing stale content.
vim.o.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  desc = "Check for external file changes and reload buffer",
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

-- Self-heal Treesitter parsers: the new nvim-treesitter API does NOT
-- auto-install `ensure_installed` on every startup (only once, via the
-- plugin's `build` hook), so a parser can silently go missing. Check once
-- per session and install anything missing.
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  once = true,
  callback = function()
    vim.defer_fn(function()
      local ok_ts, ts = pcall(require, "nvim-treesitter")
      local ok_cfg, ts_config = pcall(require, "nvim-treesitter.config")
      if not (ok_ts and ok_cfg) then
        return
      end
      local wanted =
        { "vim", "lua", "vimdoc", "html", "css", "scss", "json", "vue", "twig", "php", "javascript", "typescript", "tsx" }
      local installed = {}
      for _, l in ipairs(ts_config.get_installed "parsers") do
        installed[l] = true
      end
      local missing = vim.tbl_filter(function(l)
        return not installed[l]
      end, wanted)
      if #missing > 0 then
        vim.notify("Installing missing Treesitter parsers: " .. table.concat(missing, ", "))
        ts.install(missing)
      end
    end, 200)
  end,
})
