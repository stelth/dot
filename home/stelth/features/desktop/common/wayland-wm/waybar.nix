{
  config,
  lib,
  pkgs,
  ...
}: let
  # Dependencies
  jq = "${pkgs.jq}/bin/jq";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  playerctld = "${pkgs.playerctl}/bin/playerctld";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  btm = "${pkgs.bottom}/bin/btm";
  wofi = "${pkgs.wofi}/bin/wofi";

  terminal = "${pkgs.foot}/bin/foot";
  terminal-spawn = cmd: "${terminal} $SHELL -i -c ${cmd}";

  systemMonitor = terminal-spawn btm;

  # Function to simplify making waybar outputs
  jsonOutput = name: {
    pre ? "",
    text ? "",
    tooltip ? "",
    alt ? "",
    class ? "",
    percentage ? "",
  }: "${pkgs.writeShellScriptBin "waybar-${name}" ''
    set -euo pipefail
    ${pre}
    ${jq} -cn \
      --arg text "${text}" \
      --arg tooltip "${tooltip}" \
      --arg alt "${alt}" \
      --arg class "${class}" \
      --arg percentage "${percentage}" \
      '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
  ''}/bin/waybar-${name}";
in {
  programs.waybar = {
    enable = true;
    settings = {
      secondary = {
        mode = "dock";
        layer = "top";
        height = 32;
        width = 100;
        margin = "6";
        position = "bottom";
        modules-center = lib.optionals config.wayland.windowManager.sway.enable [
          "sway/workspaces"
          "sway/mode"
        ]; # ++ (lib.optionals config.wayland.windowManager.hyprland.enable [
        # "wlr/workspaces"
        # ]);

        "wlr/workspaces" = {
          on-click = "activate";
        };
      };

      primary = {
        mode = "dock";
        layer = "top";
        height = 40;
        margin = "6";
        position = "top";
        output = builtins.map (m: m.name) (builtins.filter (m: ! m.noBar) config.monitors);
        modules-left = [
          "custom/menu"
          "custom/currentplayer"
          "custom/player"
        ];
        modules-center = [
          "cpu"
          "custom/gpu"
          "memory"
          "clock"
          "pulseaudio"
          "custom/unread-mail"
          "custom/gammastep"
          "custom/gpg-agent"
        ];
        modules-right = [
          "custom/gamemode"
          "network"
          "custom/tailscale-ping"
          "battery"
          "tray"
          "custom/hostname"
        ];

        clock = {
          format = "{:%d/%m %H:%M}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        cpu = {
          format = "   {usage}%";
          on-click = systemMonitor;
        };
        memory = {
          format = "  {}%";
          interval = 5;
          on-click = systemMonitor;
        };
        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "   0%";
          format-icons = {
            headphone = "";
            headset = "";
            portable = "";
            default = ["" "" ""];
          };
          on-click = pavucontrol;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "零";
            deactivated = "鈴";
          };
        };
        battery = {
          bat = "BAT0";
          interval = 10;
          format-icons = ["" "" "" "" "" "" "" "" "" ""];
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          onclick = "";
        };
        "sway/window" = {
          max-length = 20;
        };
        network = {
          interval = 3;
          format-wifi = "   {essid}";
          format-ethernet = " Connected";
          format-disconnected = "";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
          on-click = "";
        };
        "custom/menu" = {
          return-type = "json";
          exec = jsonOutput "menu" {
            text = "";
            tooltip = ''$(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f2)'';
          };
          on-click = "${wofi} -S drun -x 10 -y 10 -W 25% -H 60%";
        };
        "custom/hostname" = {
          exec = "echo $USER@$(hostname)";
          on-click = terminal;
        };
        "custom/currentplayer" = {
          interval = 2;
          return-type = "json";
          exec = jsonOutput "currentplayer" {
            pre = ''
              player="$(${playerctl} status -f "{{playerName}}" 2>/dev/null || echo "No player active" | cut -d '.' -f1)"
              count="$(${playerctl} -l | wc -l)"
              if ((count > 1)); then
                more=" +$((count - 1))"
              else
                more=""
              fi
            '';
            alt = "$player";
            tooltip = "$player ($count available)";
            text = "$more";
          };
          format = "{icon}{}";
          format-icons = {
            "No player active" = " ";
            "Celluloid" = " ";
            "spotify" = " 阮";
            "ncspot" = " 阮";
            "qutebrowser" = "爵";
            "firefox" = " ";
            "discord" = " ﭮ ";
            "sublimemusic" = " ";
            "kdeconnect" = " ";
          };
          on-click = "${playerctld} shift";
          on-click-right = "${playerctld} unshift";
        };
        "custom/player" = {
          exec-if = "${playerctl} status";
          exec = ''${playerctl} metadata --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "tooltip": "{{title}} ({{artist}} - {{album}})"}' '';
          return-type = "json";
          interval = 2;
          max-length = 30;
          format = "{icon} {}";
          format-icons = {
            "Playing" = "契";
            "Paused" = " ";
            "Stopped" = "栗";
          };
          on-click = "${playerctl} play-pause";
        };
      };
    };
    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
    style = let
      inherit (config.colorscheme) colors;
    in
      /*
      css
      */
      ''
        * {
          font-family: ${config.fontProfiles.regular.family}, ${config.fontProfiles.monospace.family};
          font-size: 12pt;
          padding: 0 8px;
        }

        .modules-right {
          margin-right: -15px;
        }

        .modules-left {
          margin-left: -15px;
        }

        window#waybar.top {
          opacity: 0.95;
          padding: 0;
          background-color: #${colors.base00};
          border: 2px solid #${colors.base0C};
          border-radius: 10px;
        }
        window#waybar.bottom {
          opacity: 0.90;
          background-color: #${colors.base00};
          border: 2px solid #${colors.base0C};
          border-radius: 10px;
        }

        window#waybar {
          color: #${colors.base05};
        }

        #workspaces button {
          background-color: #${colors.base01};
          color: #${colors.base05};
          margin: 4px;
        }
        #workspaces button.hidden {
          background-color: #${colors.base00};
          color: #${colors.base04};
        }
        #workspaces button.focused,
        #workspaces button.active {
          background-color: #${colors.base0A};
          color: #${colors.base00};
        }

        #clock {
          background-color: #${colors.base0C};
          color: #${colors.base00};
          padding-left: 15px;
          padding-right: 15px;
          margin-top: 0;
          margin-bottom: 0;
          border-radius: 10px;
        }

        #custom-menu {
          background-color: #${colors.base0C};
          color: #${colors.base00};
          padding-left: 15px;
          padding-right: 22px;
          margin-left: 0;
          margin-right: 10px;
          margin-top: 0;
          margin-bottom: 0;
          border-radius: 10px;
        }
        #custom-hostname {
          background-color: #${colors.base0C};
          color: #${colors.base00};
          padding-left: 15px;
          padding-right: 18px;
          margin-right: 0;
          margin-top: 0;
          margin-bottom: 0;
          border-radius: 10px;
        }
        #tray {
          color: #${colors.base05};
        }
      '';
  };
}
