{
  config,
  hm,
  pkgs,
  ...
}: {
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  security.pam.services.swaylock = {
    text = "auth include login";
  };

  hm = {
    wayland.windowManager.sway = {
      enable = true;

      config = rec {
        modifier = "Mod4";
        terminal = "kitty";
      };
    };
  };

  programs.sway.enable = true;
  services.xserver = {
    enable = true;

    displayManager = {
      defaultSession = "sway";
      sddm = {
        enable = true;
      };
    };
  };
}
