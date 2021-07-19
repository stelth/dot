local global = require('util.global')

local M = {}

M.setup = function()
	require("persistence").setup({
		dir = global.cache_dir .. "sessions",
	})
end

return M
