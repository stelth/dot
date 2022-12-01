{
  inputs,
  config,
  pkgs,
  ...
}: let
  homeDir = config.home.homeDirectory;
in {
  imports = [
    ./1password.nix
    ./bat.nix
    ./direnv.nix
    ./dotfiles
    ./fzf.nix
    ./git.nix
    ./kitty.nix
    ./nushell.nix
    ./nvim
    ./shell.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
  ];

  manual = {
    html.enable = false;
    manpages.enable = false;
    json.enable = false;
  };

  home = {
    stateVersion = "22.11";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";
      MANROFFOPT = "-c";
      NIX_GCC = "${pkgs.gcc}/bin/gcc";
      JAVA_HOME = "${pkgs.jdk}";
    };

    packages = with pkgs; [
      alejandra
      as-tree
      aspell
      bottom
      cachix
      cargo
      cmake
      cirrus-cli
      comma
      coreutils-full
      curl
      du-dust
      gh
      ghq
      gnused
      grc
      jdk
      lua
      manix
      maven
      ninja
      nix
      nodejs_latest
      parallel
      pfetch
      ripgrep-all
      rsync
      rustc
      stable.procs
      sysdo
      tmux-cht
      tmux-sessionizer
      tokei
      treefmt
    ];
  };

  programs = {
    home-manager = {
      enable = true;
      path = "${config.home.homeDirectory}/dot/modules/home-manager";
    };
    dircolors.enable = true;
    go.enable = true;
    jq.enable = true;
    gpg.enable = true;
    htop.enable = true;
    less.enable = true;
    nix-index.enable = true;
    zoxide.enable = true;
  };
}
