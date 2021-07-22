{ inputs, config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
in
{
  imports = [
    ./cli
    ./dev
    ./dotfiles
    ./git.nix
    ./kitty
    ./nvim
    ./unsorted
  ];

  programs.home-manager = {
    enable = true;
    path = "${config.home.homeDirectory}/.nixpkgs/modules/home-manager";
  };

  home =
    let
      java = pkgs.adoptopenjdk-bin;
    in
      {
        stateVersion = "21.05";
        sessionVariables = {
          TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
          EDITOR = "nvim";
          VISUAL = "nvim";
          JAVA_HOME = "${java}";
          MANPAGER = "nvim +Man!";
          MANROFFOPT = "-c";
          NIX_GCC = "${pkgs.gcc}/bin/gcc";
        };

        packages = with pkgs; [
          coreutils-full
          curl
          gnused
          less
          rsync
        ];
      };
}
