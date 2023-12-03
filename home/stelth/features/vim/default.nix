{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.vimUtils) buildVimPlugin;
  inherit (pkgs) fetchFromGitHub;

  autosuggest-vim = buildVimPlugin {
    pname = "autosuggest-vim";
    version = "2023-11-16";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "autosuggest.vim";
      rev = "395d49fe45f08e531cd8a6590d582e2ed27864fc";
      sha256 = "412Y4PyQMYPRcJ+zscSdS2Ar5HRdVCjn+/2mEai0ZV8=";
    };
    meta.homepage = "https://github.com/girishji/autosuggest.vim";
  };

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

  vim9-lsp = buildVimPlugin {
    pname = "vim9-lsp";
    version = "2023-11-28";
    src = fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "ad380a8fb0979bf45e9bd74c8a64a7d235763b6e";
      sha256 = "sha256-H+Sn+ohNS2N02/esBuVcINRkQlv+wTk0MO3gzrbhYDM=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  };

  vimcomplete = buildVimPlugin {
    pname = "vimcomplete";
    version = "2023-11-29";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vimcomplete";
      rev = "92afa7730539b52f2ed51802d85ef3fcd21dafef";
      sha256 = "sha256-DdbmYesolC19T6EgWFenz/CTr6YcAqi+Uy/Xab5A3jg=";
    };
    meta.homepage = "https://github.com/girishji/vimcomplete";
  };

  vsnip-complete-vim = buildVimPlugin {
    pname = "vsnip-complete-vim";
    version = "2023-08-02";
    src = fetchFromGitHub {
      owner = "girishji";
      repo = "vsnip-complete.vim";
      rev = "828c94e43bf06ca04111cd56e51974af8a540778";
      sha256 = "gmS+xnLkXYjwPZxquY13GARNEq6urS6UwfDvo+NsMWM=";
    };
    meta.homepage = "https://github.com/girishji/vsnip-complete.vim";
  };
in {
  home =
    {
      packages = with pkgs; [
        cmake
        ninja

        # mandatory
        nodejs
        efm-langserver

        # language servers
        nodePackages.bash-language-server # bash
        clang-tools_16 # c/cpp
        cmake-language-server # cmake
        nodePackages.dockerfile-language-server-nodejs # docker
        nodePackages.vscode-json-languageserver # json
        marksman
        nodePackages.pyright # python
        nil # nix
        nodePackages.vim-language-server # vim
        nodePackages.yaml-language-server # yaml

        # linters / formatters
        shellcheck # bash
        shfmt # bash
        cmake-format # c/cpp
        dprint # docker
        gitlint # git
        google-java-format # java
        nodePackages.fixjson # json
        nodePackages.jsonlint # json
        nodePackages.write-good # json
        alejandra # nix
        statix # nic
        (python3.withPackages (ps: with ps; [black flake8 isort pylint])) # python
        vim-vint # vim
        yamllint # yaml
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
    "vim/vimrc".text = import ./config.nix {inherit config lib pkgs;};
    "efm-langserver/config.yaml".text = import ./efm.nix {inherit lib pkgs;};
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      source ~/.config/vim/vimrc
    '';
    plugins = with pkgs.vimPlugins; [
      auto-pairs
      autosuggest-vim
      friendly-snippets
      fzf-vim
      lightline-bufferline
      lightline-vim
      rose-pine-vim
      undotree
      vim-commentary
      vim-endwise
      vim-highlightedyank
      vim-polyglot
      vim-sensible
      vim-signify
      vim-snippets
      vim-speeddating
      vim-surround
      vim-tmux-navigator
      vim-vsnip
      vim-vsnip-integ
      vim9-lsp
      vimcomplete
      vsnip-complete-vim
    ];
  };
}
