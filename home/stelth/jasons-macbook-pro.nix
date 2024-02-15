{pkgs, ...}: {
  imports = [
    ./features/cli
    ./features/vim
  ];

  home.packages = with pkgs; [
    sysdo
  ];

  home.stateVersion = "23.11";

  home.sessionVariables.EDITOR = "vim";
}
