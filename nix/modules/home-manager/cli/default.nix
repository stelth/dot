{ config, pkgs, lib, ... }:
let
  fuzz =
    let
      fd = "${pkgs.fd}/bin/fd";
    in
      rec {
        defaultCommand = "${fd} -H --type f";
        defaultOptions = [ "--height 50%" "--border" ];
        fileWidgetCommand = "${defaultCommand}";
        fileWidgetOptions = [ "--preview '${pkgs.tree}/bin/tree -C {} | head -200'" ];
        changeDirWidgetCommand = "${fd} --type d";
        changeDirWidgetOptions = [ "--preview '${pkgs.tree}/bin/tree -C {} | head -200'" ];
      };
  aliases = {};
in
{
  imports = [
    ./fish.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [ tree ];
  programs = {
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    } // fuzz;
    bat = {
      enable = true;
      config = {
        theme = "Nord";
        color = "always";
      };
    };
    jq.enable = true;
    htop.enable = true;
    gpg.enable = true;
    git = {
      enable = true;
      lfs = {
        enable = true;
      };
      aliases = {
        ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
      };
    };
    exa = {
      enable = true;
      enableAliases = true;
    };
    bash = {
      enable = true;
      shellAliases = aliases;
    };
    zoxide.enable = true;
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = true;
      };
    };
  };
}
