require("telescope").load_extension("cmake")

vim.g.cmake_build_dir = "{os}-{build_type}-build"
vim.g.cmake_default_cmake_projects_path = vim.fn.expand("~/dev")
