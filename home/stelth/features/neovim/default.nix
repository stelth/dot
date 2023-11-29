{pkgs, ...}: {
  imports = [./plugins.nix];

  xdg.configFile = {
    "nvim/lua" = {
      recursive = true;
      source = ./lua;
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    extraPackages = with pkgs; [fd tree-sitter];

    extraLuaConfig = ''
      require('settings')
    '';
  };
}
