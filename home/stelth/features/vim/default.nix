{
  config,
  lib,
  pkgs,
  ...
}: {
  home =
    {
      packages = with pkgs; [
        cmake
        ninja
        nodejs # mandatory for coc-nvim

        # Bash
        shellcheck
        shfmt

        #C/CPP
        clang-tools_17

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

        # Makefiles
        checkmake

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
      ];
    }
    // lib.optionalAttrs (builtins.hasAttr "persistence" config.home) {
      persistence = {
        "/persist/home/stelth".directories = [
          ".config/coc"
          ".local/share/vim"
          ".local/state/vim"
        ];
      };
    };

  xdg.configFile = {
    "vim/coc-settings.json".text = import ./coc-settings.nix {inherit lib pkgs;};
  };

  programs.vim = {
    enable = true;
    extraConfig = import ./config.nix {inherit config lib pkgs;};
    plugins = with pkgs.vimPlugins; [
      catppuccin-vim
      coc-clangd
      coc-cmake
      coc-diagnostic
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
      fzf-vim
      undotree
      vim-commentary
      vim-dadbod
      vim-dadbod-ui
      vim-flagship
      vim-highlightedyank
      vim-polyglot
      vim-sensible
      vim-signify
      vim-snippets
      vim-speeddating
      vim-tmux-navigator
    ];
  };
}
