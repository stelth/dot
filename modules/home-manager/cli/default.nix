{ config, pkgs, lib, ... }:
let
  fuzz = let fd = "${pkgs.fd}/bin/fd";
  in rec {
    defaultCommand = "${fd} -H --type f";
    defaultOptions = [ "--height 50%" "--border" ];
    fileWidgetCommand = "${defaultCommand}";
    fileWidgetOptions =
      [ "--preview '${pkgs.tree}/bin/tree -C {} | head -200'" ];
    changeDirWidgetCommand = "${fd} --type d";
    changeDirWidgetOptions =
      [ "--preview '${pkgs.tree}/bin/tree -C {} | head -200'" ];
  };
  aliases = { };
in {
  imports = [ ./fish.nix ./tmux.nix ];

  home.packages = with pkgs; [ tree ];
  programs = {
    direnv = {
      enable = true;
      nix-direnv = { enable = true; };
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
      lfs = { enable = true; };
      aliases = {
        ignore =
          "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
      };
    };
    bash = {
      enable = true;
      shellAliases = aliases;
    };
    nix-index.enable = true;
    zoxide.enable = true;
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = true;

        aws = { symbol = " "; };

        battery = {
          full_symbol = "";
          charging_symbol = "";
          discharging_symbol = "";
        };

        conda = { symbol = " "; };

        dart = { symbol = " "; };

        docker_context = { symbol = " "; };

        elixir = { symbol = " "; };

        elm = { symbol = " "; };

        git_branch = { symbol = " "; };

        golang = { symbol = " "; };

        hg_branch = { symbol = " "; };

        java = { symbol = " "; };

        julia = { symbol = " "; };

        memory_usage = { symbol = " "; };

        nim = { symbol = " "; };

        nix_shell = { symbol = " "; };

        nodejs = { symbol = " "; };

        package = { symbol = " "; };

        perl = { symbol = " "; };

        php = { symbol = " "; };

        python = { symbol = " "; };

        ruby = { symbol = " "; };

        rust = { symbol = " "; };

        swift = { symbol = "ﯣ "; };
      };
    };
  };
}
