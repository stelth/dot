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
    packageConfigurable = pkgs.vim_configurable.override {
      guiSupport = "no";
      darwinSupport = true;
    };
    extraConfig = ''
      source ~/.config/vim/vimrc
    '';
  };
}
