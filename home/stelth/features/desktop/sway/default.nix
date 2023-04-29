{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../common
    ../common/wayland-wm
  ];

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
        {command = "google-chrome-beta";}
        {command = "footclient";}
        {command = "discord";}
        {
          command = let
            lockCmd = "'swaylock -f'";
          in ''
            swayidle -w \
            timeout 600 ${lockCmd} \
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
}
