local util = require("util")

local M = {}

M.local_plugins = {}

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
function M.process_local_plugins(spec)
  if type(spec) == "string" then
    local name = M.get_name(spec)

    if M.local_plugins[name] then
      return M.local_plugins[name] .. "/" .. name
    end
  else
    for i, s in ipairs(spec) do
      spec[i] = M.process_local_plugins(s)
    end
  end
  if spec.requires then
    spec.requires = M.process_local_plugins(spec.requires)
  end
  return spec
end

function M.wrap(use)
  return function(spec)
    spec = M.process_local_plugins(spec)
    use(spec)
  end
end

function M.setup(config, fn)
  -- HACK: see https://github.com/wbthomason/packer.nvim/issues/180
  vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

  M.bootstrap()
  local packer = require("packer")
  packer.init(config)
  M.local_plugins = config.local_plugins or {}
  return packer.startup({
    function(use)
      use = M.wrap(use)
      fn(use)
    end,
  })
end

return M
