{pkgs, ...}: {
  imports = [
    ./modules/cli
    ./modules/vim
  ];

  home.packages = with pkgs; [
    sysdo
  ];

  home.stateVersion = "23.11";
}
