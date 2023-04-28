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
      guiSupport = "no";
      darwinSupport = pkgs.stdenvNoCC.isDarwin;
    };
    extraConfig = ''
      source ~/.config/vim/vimrc
    '';
  };
}
