{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.vimUtils) buildVimPlugin;
  inherit (pkgs) fetchFromGitHub;

  rose-pine-vim = buildVimPlugin {
    pname = "rose-pine-vim";
    version = "2023-01-16";
    src = fetchFromGitHub {
      owner = "rose-pine";
      repo = "vim";
      rev = "d149980cfa5cdec487df23b2e9963c3256f3a9f3";
      sha256 = "a+RCmgSG+snwBVQCzSnp8wVxSoQcLqoJjnTiDviTGqc=";
    };
    meta.homepage = "https://github.com/rose-pine/vim";
  };
in {
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
        clang-tools

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
    packageConfigurable = pkgs.vim-full.override {
      guiSupport = "no";
      darwinSupport = pkgs.stdenvNoCC.isDarwin;
    };
    defaultEditor = true;
    extraConfig = import ./config.nix {inherit config lib pkgs;};
    plugins = with pkgs.vimPlugins; [
      auto-pairs
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
      rose-pine-vim
      undotree
      vim-commentary
      vim-endwise
      vim-flagship
      vim-highlightedyank
      vim-polyglot
      vim-sensible
      vim-signify
      vim-snippets
      vim-speeddating
      vim-surround
      vim-tmux-navigator
    ];
  };
}
