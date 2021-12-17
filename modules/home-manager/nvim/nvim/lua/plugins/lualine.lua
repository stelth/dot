local M = {}

local setup = function()
  local clock = function()
    return " " .. os.date("%H:%M")
  end

  local lsp_progress = function(_, is_active)
    if not is_active then
      return
    end
    local messages = vim.lsp.util.get_progress_messages()
    if #messages == 0 then
      return ""
    end
    local status = {}
    for _, msg in pairs(messages) do
      local title = ""

      if msg.title then
        title = msg.title
      end

      table.insert(status, (msg.percentage or 0) .. "%%" .. title)
    end
    local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners
    return table.concat(status, "  ") .. " " .. spinners[frame + 1]
  end

  require("util.au").group("LspProgress", function(grp)
    grp.User = {
      "LspProgressUpdate",
      function()
        vim.o.readonly = vim.o.readonly
      end,
    }
  end)

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
      lualine_x = { "filetype", lsp_progress },
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
    requires = { "kyazdani42/nvim-web-devicons" },
  })
end

return M
