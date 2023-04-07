{pkgs, ...}: {
  imports = [./plugins.nix];

  xdg.configFile = {
    vim = {
      source = ./vim;
      target = "vim";
      recursive = true;
    };
  };

  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim-full.override {
      guiSupport =
        if pkgs.stdenvNoCC.isDarwin
        then "no"
        else "gtk3";
      darwinSupport = pkgs.stdenvNoCC.isDarwin;
    };
    extraConfig = ''
      source ~/.config/vim/vimrc
    '';
  };
}
