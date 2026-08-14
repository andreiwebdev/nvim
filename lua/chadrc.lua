-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "yoru",
  transparency = true,

  -- Give the sticky treesitter-context header (and its separator line) a
  -- solid background so it stays visible over Ghostty's opacity/blur
  -- instead of inheriting the global transparency = true above.
  -- Named palette keys (not hex) so this stays correct across any base46
  -- theme, not just whichever one was active when this was written.
  hl_override = {
    TreesitterContext = { bg = "one_bg" },
    TreesitterContextSeparator = { fg = "grey" },
    TreesitterContextLineNumber = { bg = "one_bg" },
  },
}

M.nvdash = {
  load_on_startup = true,

  buttons = {
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "  New File", keys = "n", cmd = "enew" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    { txt = "  LazyGit", keys = "lg", cmd = "LazyGit" },
    { txt = "  Claude Code", keys = "cc", cmd = "ClaudeCode" },
    { txt = "  Diagnostics", keys = "xx", cmd = "Trouble diagnostics toggle" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
    { txt = "  Quit", keys = "qq", cmd = "qa" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
      content = "fit",
    },
  },
}

M.ui = {
  statusline = {
    theme = "vscode_colored",
  },
}

return M
