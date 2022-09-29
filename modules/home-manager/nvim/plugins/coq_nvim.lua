vim.g.coq_settings = {
  auto_start = "shut-up",
  xdg = true,
  keymap = {
    jump_to_mark = "<C-f>",
  },
  display = {
    icons = {
      mode = "short",
    },
  },
}

require("coq")

require("coq_3p")({
  { src = "repl", sh = "bash" },
  { src = "bc", short_name = "MATH", precision = 6 },
  { src = "vim_dadbod_completion", short_name = "DB" },
  { src = "dap" },
  { src = "nvimlua", short_name = "nLUA", conf_only = false },
})
