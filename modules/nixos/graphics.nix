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

  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [polkit_gnome wl-clipboard wofi];

  hm = {
    xdg.configFile = {
      # "waybar/style.css" = {source = ./config/waybar.css;};
      "wofi/style.css" = {source = ./config/wofi.css;};
    };

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures = {
        gtk = true;
      };

      config = rec {
        modifier = "Mod4";
        terminal = "kitty";
        menu = "${pkgs.wofi}/bin/wofi --show run";
        startup = [
          {command = "1password";}
        ];
        bars = [{command = "${config.programs.waybar.package}/bin/waybar";}];
      };
    };

    services.mako = {
      enable = true;
      backgroundColor = "#282C34";
      textColor = "#ABB2BF";
      borderColor = "#2C323C";
      defaultTimeout = 5000;

      extraConfig = ''
        [urgency=high]
        text-color=#CB4B16
      '';
    };

    programs.waybar = {
      enable = true;
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
