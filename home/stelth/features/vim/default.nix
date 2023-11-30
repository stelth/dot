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
  imports = [
    ./dev.nix
    ./lsp.nix
  ];

  home = lib.optionalAttrs (builtins.hasAttr "persistence" config.home) {
    persistence = {
      "/persist/home/stelth".directories = [
        ".config/coc"
        ".local/share/vim"
        ".local/state/vim"
      ];
    };
  };

  xdg.configFile."vim/vimrc".text = import ./config.nix {
    inherit config lib pkgs;
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      source ~/.config/vim/vimrc
    '';
    plugins = with pkgs.vimPlugins; [
      asyncrun-vim
      asynctasks-vim
      auto-pairs
      autosuggest-vim
      fzf-vim
      is-vim
      lightline-bufferline
      lightline-vim
      markdown-preview-nvim
      rose-pine-vim
      undotree
      vim-dispatch
      vim-eunuch
      vim-fugitive
      vim-markdown-toc
      vim-orgmode
      vim-pager
      vim-repeat
      vim-sensible
      vim-signify
      vim-sleuth
      vim-speeddating
      vim-surround
      vim-tmux-navigator
      vim-unimpaired
      vim-vinegar
      vimcomplete
      vsnip-complete-vim
    ];
  };
}
