{pkgs, ...}: {
  imports = [
    ./features/cli
    ./features/neovim
  ];

  home.packages = with pkgs; [
    sysdo
  ];

  home.stateVersion = "23.11";

  programs.neovim = {
    defaultEditor = true;
    vimAlias = true;
  };
}
