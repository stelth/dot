{pkgs, ...}: {
  imports = [
    ./features/cli
    ./features/neovim
    # ./features/vim
  ];

  home.packages = with pkgs; [
    sysdo
  ];

  home.stateVersion = "23.11";
}
