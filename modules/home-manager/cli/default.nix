{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./fish.nix ./tmux.nix];

  home.packages = with pkgs; [tree];
  programs = {
    direnv = {
      enable = true;
      nix-direnv = {enable = true;};
    };
    fzf = rec {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      defaultCommand = "${pkgs.fd}/bin/fd --type f";
      defaultOptions = ["--height 50%"];
      fileWidgetCommand = "${defaultCommand}";
      fileWidgetOptions = [
        "--preview '${pkgs.bat}/bin/bat --color=always --plain --line-range=:200 {}'"
      ];
      changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
      changeDirWidgetOptions = ["--preview '${pkgs.tree}/bin/tree -C {} | head -200'"];
      historyWidgetOptions = [];
    };
    bat = {
      enable = true;
      config = {
        theme = "gruvbox-dark";
        color = "always";
      };
    };
    jq.enable = true;
    htop.enable = true;
    gpg.enable = true;
    git = {
      enable = true;
      lfs = {enable = true;};
      aliases = {
        ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
      };
    };
    bash = {enable = true;};
    nix-index.enable = true;
    zoxide.enable = true;
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {add_newline = true;};
    };
  };
}
