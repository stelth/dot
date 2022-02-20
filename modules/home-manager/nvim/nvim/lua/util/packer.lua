local M = {}

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
