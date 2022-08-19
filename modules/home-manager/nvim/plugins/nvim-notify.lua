require("notify").setup({
  fps = 60,
  stages = "slide",
  timeout = 2000,
})

vim.notify = function(msg, log_level, opts)
  if msg:match("offset_encodings") then
    return
  end
  require("notify").notify(msg, log_level, opts)
end
