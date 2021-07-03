{ pkgs, config, home-manager, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;

  darwinPackages = with pkgs; [
    coreutils
    gnused
    curl
    wget
    fontconfig
    kitty
    less
    rsync
  ];

  kmonad = (import ./kmonad.nix) pkgs;

  linuxPackages = with pkgs; [
    kmonad
  ];
in
{
  home.packages = with pkgs; [
    as-tree
    aspell
    bat
    bandwhich
    bottom
    broot
    delta
    du-dust
    exa
    fd
    direnv
    nix-direnv
    fzf
    fzy
    grc
    glow
    gnused
    htop
    hyperfine
    jq
    lazygit
    manix
    mdcat
    nix-index
    ncdu
    nixUnstable
    pfetch
    procs
    ripgrep
    shellcheck
    shfmt
    starship
    tealdeer
    tmux
    tmuxinator
    tokei
    zoxide
  ] ++ (if isDarwin then darwinPackages else linuxPackages);

  programs.direnv.enable = true;
  programs.direnv.nix-direnv = {
    enable = true;
    enableFlakes = true;
  };
}
