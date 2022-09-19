local tasks = require("tasks")
local dapui = require("dapui")

tasks.setup({
  dap_open_command = dapui.open,
})

local f_index = 13
for _, task_name in ipairs({ "debug", "run", "build" }) do
  vim.keymap.set({ "", "i" }, string.format("<F%d>", f_index), function()
    tasks.start("auto", task_name)
  end, {})
  vim.keymap.set({ "", "i" }, string.format("<S-F%d>", f_index), function()
    tasks.set_task_param("auto", task_name, "args")
  end, {})
  vim.keymap.set({ "", "i" }, string.format("<A-F%d>", f_index), function()
    tasks.set_task_param("auto", task_name, "env")
  end, {})
  f_index = f_index + 1
end

vim.keymap.set({ "", "i" }, "<F16>", function()
  tasks.set_module_param("auto", "target")
end, {})

vim.keymap.set({ "", "i" }, "<F17>", function()
  tasks.set_module_param("auto", "build")
end, {})

vim.keymap.set({ "", "i" }, "<F18>", function()
  tasks.start("auto", "configure")
end, {})

vim.keymap.set({ "", "i" }, "<F19>", function()
  tasks.start("auto", "clean")
end, {})

vim.keymap.set({ "", "i" }, "<F20>", function()
  tasks.cancel()
  dapui.close()
end, {})
