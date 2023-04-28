{pkgs, ...}: {
  imports = [./git.nix ./starship.nix ./tmux.nix ./zsh.nix];

  home.packages = with pkgs; [
    comma
    bc
    bottom
    ncdu
    exa
    ripgrep
    diffsitter
    jq
  ];
}
