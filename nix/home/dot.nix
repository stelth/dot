{ pkgs, config, home-manager, ... }:
let
  util = (import ./util.nix) { config = config; };
  isDarwin = pkgs.stdenv.isDarwin;

  extraHome = if pkgs.stdenv.isDarwin then {} else {};
in
{
  home.sessionVariables = {
    TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
    SHELL = "${pkgs.fish}/bin/fish";
    NIX_GCC = "${pkgs.gcc}/bin/gcc";
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
    MANROFFOPT = "-c";
  };

  programs.bash = {
    enable = true;
    initExtra = "source <(starship init bash --print-full-init)";
  };

  programs.zsh = {
    enable = true;
    initExtra = "source <(starship init zsh --print-full-init)";
  };
}
