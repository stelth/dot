{pkgs, ...}: {
  imports = [
    ./features/cli
    ./features/vim
    ./features/neovim
  ];

  home.packages = with pkgs; [
    sysdo
  ];

  home.stateVersion = "23.11";
}
