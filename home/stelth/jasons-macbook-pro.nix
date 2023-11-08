{pkgs, ...}: {
  imports = [
    ../../darwin/modules/cli
    ../../darwin/modules/vim
  ];

  home.packages = with pkgs; [
    sysdo
  ];

  home.stateVersion = "23.11";
}
