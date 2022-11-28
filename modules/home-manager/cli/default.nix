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
      settings = {
        add_newline = true;

        battery = {
          full_symbol = "";
          charging_symbol = "";
          discharging_symbol = "";
        };
        aws = {
          symbol = "  ";
        };
        buf = {
          symbol = " ";
        };
        c = {
          symbol = " ";
        };
        conda = {
          symbol = " ";
        };
        dart = {
          symbol = " ";
        };
        directory = {
          read_only = " ";
        };
        docker_context = {
          symbol = " ";
        };
        elixir = {
          symbol = " ";
        };
        elm = {
          symbol = " ";
        };
        git_branch = {
          symbol = " ";
        };
        golang = {
          symbol = " ";
        };
        haskell = {
          symbol = " ";
        };
        hg_branch = {
          symbol = " ";
        };
        java = {
          symbol = " ";
        };
        julia = {
          symbol = " ";
        };
        lua = {
          symbol = " ";
        };
        memory_usage = {
          symbol = " ";
        };
        meson = {
          symbol = "喝 ";
        };
        nim = {
          symbol = " ";
        };
        nix_shell = {
          symbol = " ";
        };
        nodejs = {
          symbol = " ";
        };
        package = {
          symbol = " ";
        };
        python = {
          symbol = " ";
        };
        rlang = {
          symbol = "ﳒ ";
        };
        ruby = {
          symbol = " ";
        };
        rust = {
          symbol = " ";
        };
        scala = {
          symbol = " ";
        };
        spack = {
          symbol = "🅢 ";
        };
      };
    };
  };
}
