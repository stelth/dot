{...}: {
  home = {
    sessionVariables = {
      TERMINAL = "footclient";
    };
  };

  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main.font = "monospace:pixelsize=11";
      colors = import ./theme.nix {};
      tweak = {
        max-shm-pool-size-mb = 2048;
      };
    };
  };
}
