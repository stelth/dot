local util = require("util")

local M = {}

function M.bootstrap()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd("packadd packer.nvim")
  end
  vim.cmd([[packadd packer.nvim]])
end

function M.get_name(pkg)
  local parts = vim.split(pkg, "/")
  return parts[#parts]
end

-- This method replaces any plugins with the local clone under ~/projects
function M.process_plugins(spec)
  if spec.requires then
    spec.requires = M.process_plugins(spec.requires)
  end
  return spec
end

function M.wrap(use)
  return function(spec)
    spec = M.process_plugins(spec)
    use(spec)
  end
end

function M.setup(config, fn)
  -- HACK: see https://github.com/wbthomason/packer.nvim/issues/180
  vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

  M.bootstrap()
  local packer = require("packer")
  packer.init(config)
  return packer.startup({
    function(use)
      use = M.wrap(use)
      fn(use)
    end,
  })
end

return M
