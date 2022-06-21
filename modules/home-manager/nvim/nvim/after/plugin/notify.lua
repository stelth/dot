vim.notify = function(msg, log_level, opts)
  if msg:match("offset_encodings") then
    return
  end
  require("notify").notify(msg, log_level, opts)
end

require("telescope").load_extension("notify")
