{ inputs, config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  pyEnv = pkgs.python3.withPackages
    (ps: with ps; [ black typer colorama shellingham ]);
  sysDoNixos =
    "[[ -d /etc/nixos ]] && cd /etc/nixos && ${pyEnv}/bin/python bin/do.py $@";
  sysDoDarwin =
    "[[ -d ${homeDir}/dot ]] && cd ${homeDir}/dot && ${pyEnv}/bin/python bin/do.py $@";
  sysdo = pkgs.writeShellScriptBin "sysdo" ''
    (${sysDoNixos}) || (${sysDoDarwin})
  '';
in {
  imports = [ ./cli ./dev ./dotfiles ./git.nix ./nvim ./1password ];

  programs.home-manager = {
    enable = true;
    path = "${config.home.homeDirectory}/dot/modules/home-manager";
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
