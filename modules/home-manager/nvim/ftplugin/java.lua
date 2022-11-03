local on_attach = require("plugins.lsp.config").on_attach

local root_markers = { "gradlew", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local home = os.getenv("HOME")
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

require("jdtls").start_or_attach({
  cmd = { "jdt-language-server", "-data", workspace_folder },
  on_attach = on_attach,
})
