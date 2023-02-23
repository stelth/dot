{
  config, pkgs,
  lib,
  ...
}: {
  imports = [./plugins.nix];

  home.file = {
    vim = {
      source = ./vim;
      target = ".vim";
      recursive = true;
    };
  };

  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim_configurable.override {
      guiSupport = "no";
      darwinSupport = true;
    };
    settings = {
      number = true;
      relativenumber = true;
    };
    extraConfig = ''
      set clipboard=unnamed

      let g:onedark_terminal_italics=1

      colorscheme onedark

      let g:ale_disable_lsp = 1
      let g:ale_floating_preview = 1
    '';
  };
}
