{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./plugins.nix];

  xdg.configFile = {
    "nvim/lua" = {
      recursive = true;
      source = ./lua;
    };
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    vimAlias = false;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    extraPackages = with pkgs; [fd tree-sitter];

    extraConfig = ''
      lua<<EOF
      require('settings')
      EOF
    '';
  };
}
