{
  pkgs,
  config,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
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
      colors = {
        foreground = "${colors.base05}";
        background = "${colors.base00}";
        alpha = 0.9;
        regular0 = "${colors.base00}";
        regular1 = "${colors.base08}";
        regular2 = "${colors.base0B}";
        regular3 = "${colors.base0A}";
        regular4 = "${colors.base0D}";
        regular5 = "${colors.base0E}";
        regular6 = "${colors.base0C}";
        regular7 = "${colors.base03}";
      };
      tweak = {
        max-shm-pool-size-mb = 2048;
      };
    };
  };
  systemd.user.services.foot.Service.ExecSearchPath = "${pkgs.foot}/bin:${pkgs.xdg-utils}/bin";
}
