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
    bandwhich
    bat
    bottom
    broot
    cmake
    delta
    direnv
    du-dust
    exa
    fd
    fzf
    fzy
    ghq
    glow
    gnused
    grc
    htop
    hyperfine
    jq
    lazygit
    manix
    mdcat
    ncdu
    nix-direnv
    nix-index
    nixUnstable
    pfetch
    procs
    ripgrep
    rpmextract
    shellcheck
    shfmt
    tealdeer
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
