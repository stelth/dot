{ inputs, config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  pyEnv = (pkgs.stable.python3.withPackages
    (ps: with ps; [ black pylint typer colorama shellingham ]));
  sysDoNixos =
    "[[ -d /etc/nixos ]] && cd /etc/nixos && ${pyEnv}/bin/python bin/do.py $@";
  sysDoDarwin =
    "[[ -d ${homeDir}/dot ]] && cd ${homeDir}/dot && ${pyEnv}/bin/python bin/do.py $@";
  sysdo = (pkgs.writeShellScriptBin "sysdo" ''
    (${sysDoNixos}) || (${sysDoDarwin})
  '');
in {
  imports = [ ./cli ./dev ./dotfiles ./git.nix ./kitty ./nvim ];

  programs.home-manager = {
    enable = true;
    path = "${config.home.homeDirectory}/dot/modules/home-manager";
  };

  home = {
    stateVersion = "21.11";
    sessionVariables = {
      TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
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
      bandwhich
      python3Packages.black
      bottom
      broot
      coreutils-full
      curl
      du-dust
      fzy
      ghq
      glow
      gnused
      grc
      hyperfine
      less
      manix
      ncdu
      nixfmt
      nixpkgs-fmt
      nixUnstable
      openssl
      parallel
      pfetch
      pre-commit
      procs
      ripgrep-all
      rpmextract
      rsync
      sysdo
      tealdeer
      treefmt
      tokei
    ];
  };
}
