require("lint").linters_by_ft = {
	c = { "clang-tidy", "cpplint" },
	cpp = { "clang-tidy", "cpplint" },
	gitcommit = { "commitlint" },
	json = { "jsonlint" },
	jsonc = { "jsonlint" },
	lua = { "selene" },
	markdown = { "alex", "markdownlint" },
	nix = { "statix" },
	python = { "bandit", "flake8", "pylint" },
	sh = { "shellcheck" },
	yaml = { "yamllint" },
	["*"] = { "typos" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
