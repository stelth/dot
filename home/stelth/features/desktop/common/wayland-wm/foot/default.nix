{pkgs, ...}: {
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
  systemd.user.services.foot.Service.ExecSearchPath = "${pkgs.foot}/bin:${pkgs.xdg-utils}/bin";
}
