{pkgs, ...}: {
  xdg.configFile."vim/coc-settings.json".text = builtins.toJSON {
    coc.preferences = {
      colorSupport = true;
      snippets.enable = true;
      useQuickFixForLocations = true;
    };
    codeLens.enable = true;
    diagnostic.displayByAle = true;
    diagnostic.virtualText = true;
    diagnostic.virtualTextCurrentLineOnly = false;
    highlight.colors.enable = true;
    inlayHint.enable = true;
    inlayHint.enableParameter = true;
    signature.enable = true;
    suggest.removeDuplicateItems = true;
    suggest.noselect = false;
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
    plugins = with pkgs.vimPlugins; [
      ale
      coc-clangd
      coc-cmake
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
