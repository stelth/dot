require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.integrations.nvim-cmp"] = {},
    ["core.presenter"] = {
      config = {
        zen_mode = "zen-mode",
      },
    },
  },
})
