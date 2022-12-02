local tasks = require("tasks")
local dapui = require("dapui")

tasks.setup({
  dap_open_command = dapui.open,
})

vim.keymap.set({ "", "i" }, "<C-BS>", function()
  tasks.cancel()
  dapui.close()
end, { desc = "Cancel last task" })

local key_index = 1
for _, task_name in ipairs({ "build", "run", "debug", "test", "debug_test" }) do
  vim.keymap.set({ "", "i" }, string.format("<F%d>", key_index), function()
    tasks.start("auto", task_name)
  end, { desc = string.format("Run %s task", task_name) })

  vim.keymap.set({ "", "i" }, string.format("<S-F%d>", key_index), function()
    tasks.set_task_param("auto", task_name, "args")
  end, { noremap = true, desc = string.format("Set args for %s task", task_name) })

  vim.keymap.set({ "", "i" }, string.format("<A-F%d>", key_index), function()
    tasks.set_task_param("auto", task_name, "env")
  end, { noremap = true, desc = string.format("Set env for %s task", task_name) })

  key_index = key_index + 1
end

vim.keymap.set({ "", "i" }, "<F6>", function()
  tasks.start("auto", "configure")
end, { desc = "Run CMake configure task" })
vim.keymap.set({ "", "i" }, "<S-F6>", function()
  tasks.set_module_param("auto", "build")
end, { desc = "Select CMake build type" })
vim.keymap.set({ "", "i" }, "<A-F6>", function()
  tasks.set_module_param("auto", "target")
end, { desc = "Select CMake target" })

vim.keymap.set({ "", "i" }, "<F7>", function()
  tasks.start("auto", "check")
end, { desc = "Run Cargo check task" })
vim.keymap.set({ "", "i" }, "<S-F7>", function()
  tasks.start("auto", "clippy")
end, { desc = "Run Cargo clippy task" })
vim.keymap.set({ "", "i" }, "<A-F7>", function()
  tasks.start("auto", "clean")
end, { desc = "Run clean task" })

vim.keymap.set({ "" }, "gob", function()
  tasks.start("auto", "open_build_dir")
end, { desc = "Open CMake build directory" })
