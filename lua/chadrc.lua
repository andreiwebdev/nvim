-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",
  transparency = true,

  -- Give the sticky treesitter-context header (and its separator line) a
  -- solid background so it stays visible over Ghostty's opacity/blur
  -- instead of inheriting the global transparency = true above.
  hl_override = {
    TreesitterContext = { bg = "#282c34" },
    TreesitterContextSeparator = { fg = "#3e4451" },
    TreesitterContextLineNumber = { bg = "#282c34" },
  },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
