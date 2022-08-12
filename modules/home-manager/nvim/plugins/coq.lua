vim.g.coq_settings = {
  auto_start = "shut-up",
  xdg = true,
}

require("coq")

require("coq_3p")({
  { src = "repl", sh = "bash" },
  { src = "bc", short_name = "MATH", precision = 6 },
  { src = "dap" },
})
