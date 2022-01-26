local M = {}

local setup = function()
  local clock = function()
    return " " .. os.date("%H:%M")
  end

  local gps = require("nvim-gps")

  local config = {
    options = {
      theme = "tokyonight",
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
      -- section_separators = { "", "" },
      -- component_separators = { "", "" },
      icons_enabled = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {
        { "diagnostics", sources = { "nvim_diagnostic" } },
        { "filename", path = 1 },
        { gps.get_location, cond = gps.is_available },
      },
      lualine_x = { "filetype" },
      lualine_y = { "progress" },
      lualine_z = { clock },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  }

  require("lualine").setup(config)
end

M.use = function(use)
  use({
    "nvim-lualine/lualine.nvim",
    config = setup,
    requires = {
      "kyazdani42/nvim-web-devicons",
      "Smitesh/nvim-gps",
    },
  })
end

return M
