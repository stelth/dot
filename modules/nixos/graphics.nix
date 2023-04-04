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
          {command = "google-chrome-stable";}
          {command = "kitty";}
          {command = "discord";}
        ];
        keybindings = let
          inherit modifier;
        in
          pkgs.lib.mkOptionDefault {
            # Focus
            "${modifier}+Left" = "focus left";
            "${modifier}+Right" = "focus right";
            "${modifier}+Up" = "focus up";
            "${modifier}+Down" = "focus down";

            # Move
            "${modifier}+Shift+Left" = "focus left";
            "${modifier}+Shift+Right" = "focus right";
            "${modifier}+Shift+Up" = "focus up";
            "${modifier}+Shift+Down" = "focus down";

            "${modifier}+Shift+space" = "floating toggle";
            "${modifier}+space" = "focus mode_toggle";
            "${modifier}+h" = "split h";
            "${modifier}+v" = "split v";
            "${modifier}+f" = "fullscreen toggle";
            "${modifier}+comma" = "layout stacking";
            "${modifier}+period" = "layout tabbed";
            "${modifier}+slash" = "layout toggle split";
            "${modifier}+a" = "focus parent";
            "${modifier}+s" = "focus child";

            "${modifier}+Shift+c" = "reload";
            "${modifier}+Shift+r" = "restart";

            # modes
            "${modifier}+Shift+v" = ''mode "system: [r]eboot [p]oweroff [l]ogout'';
            "${modifier}+r" = "mode resize";

            "${modifier}+minus" = "scratchpad show";
            "${modifier}+underscore" = "move container to scratchpad";
          };
        bars = [{command = "${config.programs.waybar.package}/bin/waybar";}];
        modes = {
          "system: [r]eboot [p]oweroff [l]ogout" = {
            r = "exec reboot";
            p = "exec poweroff";
            l = "exit";
            Return = "mode default";
            Escape = "mode default";
          };
          resize = {
            Left = "resize shrink width";
            Right = "resize grow width";
            Down = "resize shrink height";
            Up = "resize grow height";
            Return = "mode default";
            Escape = "mode default";
          };
        };
        window.commands = [
          {
            command = "inhibit_idle fullscreen";
            criteria.class = "Google-chrome";
          }
          {
            command = "move to scratchpad";
            criteria = {
              class = "1Password";
            };
          }
        ];
        assigns = {
          "1" = [{app_id = "kitty";}];
          "2" = [
            {class = "Google-chrome";}
            {class = "discord";}
          ];
        };
        workspaceOutputAssign = [
          {
            workspace = "1";
            output = "DP-1";
          }
          {
            workspace = "2";
            output = "DP-2";
          }
        ];
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
