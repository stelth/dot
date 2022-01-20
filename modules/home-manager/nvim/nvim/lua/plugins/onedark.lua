local M = {}

local setup = function()
  require("onedark").setup({
    dark_float = false,
    dark_sidebar = false,
    highlight_linenumber = true,
    hide_inactive_statusline = true,
    comment_style = "italic",
    keyword_style = "italic",
    overrides = function(c)
      return {
        LightspeedGreyWash = { fg = c.dark3 },
        LightspeedLabel = { fg = c.magenta2, style = "bold,underline" },
        LightspeedLabelDistant = { fg = c.green1, style = "bold,underline" },
        LightspeedLabelDistantOverlapped = { fg = c.green2, style = "underline" },
        LightspeedLabelOverlapped = { fg = c.magenta2, style = "underline" },
        LightspeedMaskedChar = { fg = c.orange },
        LightspeedOneCharMatch = { bg = c.magenta2, fg = c.fg, style = "bold" },
        LightspeedPendingOpArea = { bg = c.magenta2, fg = c.fg },
        LightspeedShortcut = { bg = c.magenta2, fg = c.fg, style = "bold,underline" },
        LightspeedUnlabeledMatch = { fg = c.blue2, style = "bold" },
      }
    end,
  })
end

M.use = function(use)
  use({
    "ful1e5/onedark.nvim",
    config = setup,
  })
end

return M
