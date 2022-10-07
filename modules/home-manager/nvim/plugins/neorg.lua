require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.export"] = {},
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.looking-glass"] = {},
    ["core.export.markdown"] = {
      config = {
        extensions = "all",
      },
    },
    ["core.norg.concealer"] = {
      config = {
        icon_preset = "diamond",
        conceal = true,
      },
    },
    ["core.presenter"] = {
      config = {
        zen_mode = "zen-mode",
      },
    },
    ["core.norg.esupports.metagen"] = {
      config = {
        type = "auto",
      },
    },
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
        neorg_leader = "<leader>",
      },
    },
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          home = "~/notes/home",
          work = "~/notes/work",
        },
        index = "index.norg",
      },
    },
    ["core.norg.qol.toc"] = {
      config = {
        close_split_on_jump = false,
        toc_split_placement = "left",
      },
    },
    ["core.norg.journal"] = {
      config = {
        workspace = "home",
        journal_folder = "journal",
        use_folders = false,
      },
    },
    ["core.gtd.base"] = {
      config = {
        workspace = "work",
      },
    },
  },
})
