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

  environment.systemPackages = with pkgs; [polkit_gnome];

  hm = {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures = {
        gtk = true;
      };

      config = rec {
        modifier = "Mod4";
        terminal = "kitty";
      };
    };
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
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
