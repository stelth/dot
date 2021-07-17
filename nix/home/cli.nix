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
    fish
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
    starship
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

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    keyMode = "vi";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      tmuxPlugins.yank
      tmuxPlugins.nord
      tmuxPlugins.prefix-highlight
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'off'
        '';
      }
      {
        plugin = tmuxPlugins.tilish;
        extraConfig = ''
          set -g @tilish-default 'tiled'
        '';
      }
    ];
    extraConfig = ''
      set -g mouse on
      set -g renumber-windows on
      setw -g monitor-activity on
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
    '';
  };
}
