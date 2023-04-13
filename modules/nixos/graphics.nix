{
  config,
  hm,
  pkgs,
  ...
}: let
  theme = "Adwaita";
  colorscheme = import ./colors.nix;
in {
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

  environment.systemPackages = with pkgs; [polkit_gnome wl-clipboard wofi swaylock swayidle gnome-themes-extra gnome.adwaita-icon-theme];

  fonts = {
    enableDefaultFonts = false;

    fonts = with pkgs; [
      dejavu_fonts
      freefont_ttf
      go-font
      gyre-fonts
      (iosevka.override {
        set = "slab-terminal";
        privateBuildPlan = {
          family = "Iosevka Slab Terminal";
          spacing = "term";
          serifs = "slab";
          no-cv-ss = false;
          no-litigation = true;
        };
      })
      liberation_ttf
      libertine
      noto-fonts
      noto-fonts-emoji
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Equity Text A" "DejaVu Serif"];
        sansSerif = ["Concourse T4" "DejaVu Sans"];
        monospace = ["Iosevka Slab Terminal Extended" "Dejavu Sans Mono"];
      };
    };
  };

  hm = {
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main.font = "monospace:pixelsize=11";
        colors = {
          foreground = colorscheme.dark.fg_0;
          background = colorscheme.dark.bg_0;
          alpha = 0.9;
          regular0 = colorscheme.dark.bg_1;
          regular1 = colorscheme.dark.red;
          regular2 = colorscheme.dark.green;
          regular3 = colorscheme.dark.yellow;
          regular4 = colorscheme.dark.blue;
          regular5 = colorscheme.dark.magenta;
          regular6 = colorscheme.dark.cyan;
          regular7 = colorscheme.dark.dim_0;
          bright0 = colorscheme.dark.bg_2;
          bright1 = colorscheme.dark.br_red;
          bright2 = colorscheme.dark.br_green;
          bright3 = colorscheme.dark.br_yellow;
          bright4 = colorscheme.dark.br_blue;
          bright5 = colorscheme.dark.br_magenta;
          bright6 = colorscheme.dark.br_cyan;
          bright7 = colorscheme.dark.fg_1;
        };
        tweak = {
          max-shm-pool-size-mb = 2048;
        };
      };
    };
    systemd.user.services.foot.Service.ExecSearchPath = "${pkgs.foot}/bin:${pkgs.xdg-utils}/bin";

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
        terminal = "${pkgs.foot}/bin/footclient";
        menu = "${pkgs.wofi}/bin/wofi --show run";
        startup = [
          {command = "1password";}
          {command = "google-chrome-stable";}
          {command = "footclient";}
          {command = "discord";}
          {
            command = let
              lockCmd = "'swaylock -f'";
            in ''
              swayidle -w \
              timeout 600 "${lockCmd}" \
              timeout 1200 'swaymsg "output * dpms off"' \
              resume 'swaymsg "output * dpms on"' \
              before-sleep ${lockCmd}
            '';
          }
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
            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Right" = "move right";
            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+Down" = "move down";

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

            "${modifier}+l" = ''exec ${pkgs.swaylock}/bin/swaylock'';

            "${modifier}+Shift+c" = "reload";
            "${modifier}+Shift+r" = "restart";

            # modes
            "${modifier}+Shift+v" = ''mode "system: [r]eboot [p]oweroff [l]ogout'';
            "${modifier}+r" = "mode resize";

            "${modifier}+minus" = "scratchpad show";
            "${modifier}+underscore" = "move container to scratchpad";

            "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
            "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
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
            command = "move to scratchpad";
            criteria = {
              class = "1Password";
            };
          }
        ];
        assigns = {
          "1" = [{app_id = "foot";}];
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
      backgroundColor = "#${colorscheme.dark.green}e6";
      textColor = "#${colorscheme.dark.fg_1}";
      borderColor = "#${colorscheme.dark.fg_0}";
      defaultTimeout = 5000;

      extraConfig = ''
        [urgency=high]
        text-color=#CB4B16
      '';
    };

    programs.waybar = {
      enable = true;
    };

    gtk.iconTheme.name = theme;
    gtk.theme.name = theme;
  };

  systemd = {
    user.services = {
      polkit-gnome-authentication-agent-1 = {
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
  };

  programs.sway.enable = true;
  services.xserver = {
    enable = true;

    displayManager = {
      defaultSession = "sway";
      gdm = {
        enable = true;
        wayland = true;
      };
    };
  };
}
