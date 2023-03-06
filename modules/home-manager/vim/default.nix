{pkgs, ...}: {
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
    extraConfig = builtins.readFile ./vimrc;
  };
}
