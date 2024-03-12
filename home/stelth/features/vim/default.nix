{
  config,
  lib,
  pkgs,
  ...
}: let
  pkgConfigurable =
    if pkgs.stdenvNoCC.isDarwin
    then pkgs.vim-darwin
    else pkgs.vim-full;

  my_vim = pkgConfigurable.customize {
    name = "vim";
    vimrcConfig = {
      customRC = ''
        source ~/.config/vim/vimrc
      '';
      packages.myPlugins = with pkgs.vimPlugins; {
        start =
          [
            catppuccin-vim
            friendly-snippets
            lightline-vim
            undotree
            vim-commentary
            vim-highlightedyank
            vim-sensible
            vim-tmux-navigator
            vim-vsnip
            vim-vsnip-integ
            vim9-lsp
            vimcomplete
          ]
          ++ lib.optionals pkgs.stdenvNoCC.isLinux [pkgs.vimPlugins.vim-wayland-clipboard];
        opt = [
          scope-vim
        ];
      };
    };
  };
in {
  xdg.configFile = {
    "vim/vimrc".text = import ./config.nix {
      inherit lib pkgs;
    };
    "efm-langserver/config.yaml".text = import ./efm.nix {inherit lib pkgs;};
  };

  home =
    {
      packages = with pkgs; [
        my_vim

        # Mandatory
        cmake
        fd
        efm-langserver
        nodejs

        # Language servers
        nodePackages.bash-language-server # bash
        clang-tools_17 # C/CPP
        cmake-language-server # CMake
        nodePackages.vscode-json-languageserver # json
        marksman # markdown
        nil # nix
        nodePackages.pyright # python
        nodePackages.vim-language-server # viml
        nodePackages.yaml-language-server # yaml

        # Bash
        shellcheck
        shfmt

        # CMake
        gersemi

        # Git
        gitlint

        # JSON
        nodePackages.fixjson

        # Makefiles
        checkmake

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
          ".local/share/vim"
          ".local/state/vim"
        ];
      };
    };
}
