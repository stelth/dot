{pkgs, ...}: {
  xdg.configFile."vim/coc-settings.json".text = builtins.toJSON {
    coc.preferences = {
      colorSupport = true;
      snippets.enable = true;
      useQuickFixForLocations = true;
    };
    codeLens.enable = true;
    diagnostic.virtualText = true;
    diagnostic.virtualTextCurrentLineOnly = false;
    highlight.colors.enable = true;
    inlayHint.enable = true;
    inlayHint.enableParameter = true;
    signature.enable = true;
    suggest.removeDuplicateItems = true;
    suggest.noselect = false;

    diagnostic-languageserver = {
      formatters = {
        alejandra = {
          command = "alejandra";
          args = ["--quiet"];
        };
        cmake-format = {
          command = "cmake-format";
          args = ["-"];
        };
        google-java-format = {
          command = "google-java-format";
          args = ["-"];
        };
        fixjson = {
          command = "fixjson";
          args = [];
        };
      };

      linters = {
        checkmake = {
          command = "checkmake";
          args = ["--format={{.LineNumber}}:{{.Rule}}:{{.Violation}}\n"];
          sourceName = "checkmake";
          formatPattern = [
            "^(\\d+):(\\w+):(.+)$"
            {
              line = 1;
              message = 3;
            }
          ];
        };
        cmake-lint = {
          command = "cmake-lint";
          args = ["%file"];
          sourceName = "cmake-lint";
          formatPattern = [
            "^[^:]+:(\\d+),(\\d+): \\[([EWCRI])\\d+\\] *(.*)$"
            {
              line = 1;
              column = 2;
              security = 3;
              message = 4;
            }
          ];
          securities = {
            E = "error";
            W = "warning";
            C = "info";
            R = "info";
            I = "info";
          };
        };
        git-lint = {
          command = "gitlint";
          args = [];
          sourceName = "gitlint";
          isStdout = false;
          isStderr = true;
          formatPattern = [
            "^(\\d+): (\\w+) (.+)$"
            {
              line = 1;
              message = 3;
            }
          ];
        };
        statix = {
          command = "statix";
          args = ["check" "--stdin" "--format=errfmt"];
          sourceName = "statix";
          formatPattern = [
            "^.*>(\\d+):(\\d+):(.):(\\d+):(.*)$"
            {
              line = 1;
              column = 2;
              security = 3;
              message = 5;
            }
          ];
          securities = {
            E = "error";
            W = "warning";
          };
        };
        yamllint = {
          command = "yamllint";
          args = ["--format" "parsable" "-"];
          sourceName = "yamllint";
          formatPattern = [
            "^stdin:(\\d+):(\\d+): \\[(\\w+)] (.*)$"
            {
              line = 1;
              column = 2;
              security = 3;
              message = 4;
            }
          ];
          securities = {
            error = "error";
            warning = "warning";
          };
        };
      };
      filetypes = {
        c = "cpplint";
        cmake = "cmake-lint";
        cpp = "cpplint";
        dockerfile = "hadolint";
        gitcommit = "gitlint";
        make = "checkmake";
        markdown = ["vale" "write-good"];
        nix = "statix";
        python = ["flake8" "pylint"];
        sh = "shellcheck";
        vim = "vint";
        yaml = "yamllint";
      };
      formatFiletypes = {
        cmake = "cmake-format";
        java = "google-java-format";
        json = "fixjson";
        markdown = "prettier";
        nix = "alejandra";
        python = ["isort" "black"];
        sh = "shfmt";
        yaml = "prettier";
      };
    };
  };

  home.packages = with pkgs;
    [
      nodejs

      # Bash
      shellcheck
      shfmt

      #C/CPP
      clang-tools
      cpplint

      # CMake
      cmake-format

      # Docker
      hadolint

      # Git
      gitlint

      # Java
      google-java-format

      # JSON
      nodePackages.fixjson

      # Markdown
      nodePackages.prettier
      vale
      nodePackages.write-good

      # Nix
      alejandra
      statix

      # Python
      (python3.withPackages
        (ps: with ps; [black flake8 isort pylint]))

      # Vim
      vim-vint

      # YAML
      yamllint
    ]
    ++ lib.optionals (!pkgs.stdenvNoCC.isDarwin) [checkmake];

  programs.vim = {
    plugins = with pkgs.vimExtraPlugins; [
      coc-clangd
      coc-cmake
      coc-diagnostic
      coc-docker
      coc-git
      coc-json
      coc-lists
      coc-markdownlint
      coc-nvim
      coc-prettier
      coc-pyright
      coc-sh
      coc-snippets
      coc-vimlsp
      coc-yaml
    ];
  };
}
