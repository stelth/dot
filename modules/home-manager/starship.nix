{...}: {
  programs = {
    starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
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
