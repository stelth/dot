{
  inputs,
  config,
  pkgs,
  ...
}: let
  homeDir = config.home.homeDirectory;
in {
  imports = [./cli ./dev ./dotfiles ./git.nix ./kitty ./nvim ./1password];

  programs.home-manager = {
    enable = true;
    path = "${config.home.homeDirectory}/dot/modules/home-manager";
  };

  manual = {
    html.enable = false;
    manpages.enable = false;
    json.enable = false;
  };

  home = {
    stateVersion = "22.05";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      JAVA_HOME = "${pkgs.openjdk.home}";
      MANPAGER = "nvim +Man!";
      MANROFFOPT = "-c";
      NIX_GCC = "${pkgs.gcc}/bin/gcc";
    };

    packages = with pkgs; [
      as-tree
      aspell
      bottom
      comma
      coreutils-full
      curl
      du-dust
      ghq
      gnused
      grc
      less
      manix
      ncdu
      nix
      parallel
      pfetch
      stable.procs
      ripgrep-all
      rsync
      sysdo
      tokei
    ];
  };
}
