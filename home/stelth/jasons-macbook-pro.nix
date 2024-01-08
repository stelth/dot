{pkgs, ...}: {
  imports = [
    ./features/cli
    ./features/vim
  ];

  home.packages = with pkgs; [
    sysdo
  ];

  home.stateVersion = "23.11";

  programs.vim = {
    defaultEditor = true;
  };
}
