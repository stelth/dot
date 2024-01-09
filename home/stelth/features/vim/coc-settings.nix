{pkgs, ...}: ''
  {
    "coc.preferences.colorSupport": true,
    "coc.preferences.formatOnSaveFiletypes": ["*"],
    "coc.preferences.snippets.enable": true,
    "coc.preferences.useQuickFixForLocations": true,
    "codeLens.enable": true,
    "diagnostic.virtualText": true,
    "diagnostic.virtualTextCurrentLineOnly": false,
    "highlight.colors.enable": true,
    "inlayHint.enable": true,
    "inlayHint.enableParameter": true,
    "signature.enable": true,
    "suggest.removeDuplicateItems": true,
    "suggest.noselect": true,

    "clangd.path": "${pkgs.clang-tools_17}/bin/clangd",
    "clangd.arguments": [
      "--background-index",
      "--clang-tidy",
    ],

    "diagnostic-languageserver.formatters": {
      "alejandra": {
        "command": "alejandra",
        "args": ["--quiet"]
      },
      "cmake-format": {
        "command": "cmake-format",
        "args": ["-"]
      },
      "google-java-format": {
        "command": "google-java-format",
        "args": ["-"]
      },
      "fixjson": {
        "command": "fixjson",
        "args": []
      }
    },

    "diagnostic-languageserver.linters": {
      "checkmake": {
        "command": "checkmake",
        "args": ["--format={{.LineNumber}}:{{.Rule}}:{{.Violation}}\n", "%file"],
        "sourceName": "checkmake",
        "formatPattern": [
          "^(\\d+):(\\w+):(.+)$",
          {
            "line": 1,
            "message": 3
          }
        ]
      },
      "cmake-lint": {
        "command": "cmake-lint",
        "args": ["%file"],
        "sourceName": "cmake-lint",
        "formatPattern": [
          "^[^:]+:(\\d+),(\\d+): \\[([EWCRI])\\d+\\] *(.*)$",
          {
            "line": 1,
            "column": 2,
            "security": 3,
            "message": 4
          }
        ],
        "securities": {
          "E": "error",
          "W": "warning",
          "C": "info",
          "R": "info",
          "I": "info"
        }
      },
      "gitlint": {
        "command": "gitlint",
        "args": [],
        "sourceName": "gitlint",
        "isStdout": false,
        "isStderr": true,
        "formatPattern": [
          "^(\\d+): (\\w+) (.+)$",
          {
            "line": 1,
            "message": 3
          }
        ]
      },
      "statix": {
        "command": "statix",
        "args": ["check", "--stdin", "--format=errfmt"],
        "sourceName": "statix",
        "formatPattern": [
          "^.*>(\\d+):(\\d+):(.):(\\d+):(.*)$",
          {
            "line": 1,
            "column": 2,
            "security": 3,
            "message": 5
          }
        ],
        "securities": {
          "E": "error",
          "W": "warning"
        }
      },
      "yamllint": {
        "command": "yamllint",
        "args": ["--format", "parsable", "-"],
        "sourceName": "yamllint",
        "formatPattern": [
          "^stdin:(\\d+):(\\d+): \\[(\\w+)] (.*)$",
          {
            "line": 1,
            "column": 2,
            "security": 3,
            "message": 4
          }
        ],
        "securities": {
          "error": "error",
          "warning": "warning"
        }
      }
    },

    "diagnostic-languageserver.filetypes": {
      "cmake": "cmake-lint",
      "dockerfile": "hadolint",
      "gitcommit": "gitlint",
      "make": "checkmake",
      "markdown": ["vale", "write-good"],
      "nix": "statix",
      "python": ["flake8", "pylint"],
      "vim": "vint",
      "yaml": "yamllint"
    },

    "diagnostic-languageserver.formatFiletypes": {
      "cmake": "cmake-format",
      "java": "google-java-format",
      "json": "fixjson",
      "markdown": "prettier",
      "nix": "alejandra",
      "python": ["isort", "black"],
      "sh": "shfmt",
      "yaml": "prettier"
    }
  }
''
