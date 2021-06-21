local M = {}

local stylua = {
    formatCommand = "stylua -", formatStdin = true
}

local selene = {
    lintCommand = "selene --display-style quiet -",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %tarning%m", "%f:%l:%c: %tarning%m" }
}

local prettier = {
    formatCommand = "prettier --stdin --stdin-filepath ${INPUT}",
    formatStdin = true
}

local markdownlint = {
    lintCommand = "markdownlint -s",
    lintStdin = true,
    lintFormats = { "%f:%l:%c %m" }
}

local shellcheck = {
    lintCommand = "shellcheck -f gcc -x -",
    lintStdin = true,
    lintFormats = { "%f=%l:%c: %trror: %m", "%f=%l:%c: %tarning: %m", "%f=%l:%c: %tote: %m" }
}

local shfmt = {
    formatCommand = "shfmt -ci -s -bn",
    formatStdin = true
}


local flake8 = {
    lintCommand = "flake8 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local autopep8 = {
    formatCommand = "autopep8 -",
    formatStdin = true
}

local vint = {
    lintCommand = "vint -",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local clangformat = {
    formatCommand = "clang-format",
    formatStdin = true
}

M.config = {
    init_options = {
        documentFormatting = true
    },
    settings = {
        rootMarkers = {
            ".git"
        },
        languages = {
            lua = {stylua, selene},
            yaml = {prettier},
            json = {prettier},
            markdown = {prettier, markdownlint},
            sh = { shellcheck, shfmt },
            python = {flake8, autopep8},
            vim = {vint},
            cpp = {clangformat},
            c = {clangformat}
        }
    }
}

M.config.filetypes = {}
for ft, _ in pairs(M.config.settings.languages) do
    table.insert(M.config.filetypes, ft)
end

M.formatted_languages = {}
for lang, tools in pairs(M.config.settings.languages) do
    for _, tool in pairs(tools) do
        if tool.formatCommand then
            M.formatted_languages[lang] = true
        end
    end
end

return M
