{pkgs, ...}: {
  imports = [./git.nix ./starship.nix ./zsh.nix];

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
