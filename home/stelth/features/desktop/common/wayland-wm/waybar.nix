{pkgs, ...}: let
  # Dependencies
  jq = "${pkgs.jq}/bin/jq";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  playerctld = "${pkgs.playerctl}/bin/playerctld";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  btm = "${pkgs.bottom}/bin/btm";

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
      primary = {
        mode = "dock";
        layer = "top";
        height = 40;
        margin = "6";
        position = "top";
        modules-left = [
          "wlr/workspaces"
          "idle_inhibitor"
          "custom/currentplayer"
          "custom/player"
        ];
        modules-center = [
          "cpu"
          "memory"
          "clock"
          "pulseaudio"
          "custom/gpg-agent"
        ];
        modules-right = [
          "network"
          "battery"
          "tray"
          "custom/hostname"
        ];

        "wlr/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "<span color=\"#D8DEE9\">1</span>";
            "2" = "<span color=\"#88C0D0\">2</span>";
            "3" = "<span color=\"#A3BE8C\">3</span>";
            "4" = "<span color=\"#D8DEE9\">4</span>";
            "urgent" = "";
            "focused" = "";
            "default" = "";
          };
        };

        clock = {
          format = "{:%d/%m %H:%M}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        cpu = {
          format = "  {usage}%";
          on-click = systemMonitor;
        };
        memory = {
          format = "󰍛  {}%";
          interval = 5;
          on-click = systemMonitor;
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " 0%";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            portable = "";
            default = ["" "" ""];
          };
          on-click = pavucontrol;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };
        battery = {
          bat = "BAT0";
          interval = 10;
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          onclick = "";
        };
        network = {
          interval = 3;
          format-wifi = " {essid}";
          format-ethernet = "󰈁 Connected";
          format-disconnected = "";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
          on-click = "";
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
          format = "{icon}";
          format-icons = {
            "No player active" = " ";
            "Celluloid" = "󰎁 ";
            "spotify" = " 󰓇";
            "ncspot" = " 󰓇";
            "qutebrowser" = "󰖟";
            "firefox" = " ";
            "discord" = " 󰙯 ";
            "sublimemusic" = " ";
            "kdeconnect" = "󰄡 ";
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
            "Playing" = "󰐊";
            "Paused" = "󰏤 ";
            "Stopped" = "󰓛";
          };
          on-click = "${playerctl} play-pause";
        };
        "custom/gpg-agent" = {
          interval = 2;
          return-type = "json";
          exec = let
            gpgCmds = import ../../../cli/gpg-commands.nix {inherit pkgs;};
          in
            jsonOutput "gpg-agent" {
              pre = ''status=$(${gpgCmds.isUnlocked} && echo "unlocked" || echo "locked")'';
              alt = "$status";
              tooltip = "GPG is $status";
            };
          format = "{icon}";
          format-icons = {
            "locked" = "";
            "unlocked" = "";
          };
          on-click = "";
        };
      };
    };
    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
    style = ''

      @keyframes blink-warning {
          70% {
              color: @light;
          }

          to {
              color: @light;
              background-color: @warning;
          }
      }

      @keyframes blink-critical {
          70% {
            color: @light;
          }

          to {
              color: @light;
              background-color: @critical;
          }
      }


      /* -----------------------------------------------------------------------------
       * Styles
       * -------------------------------------------------------------------------- */

      /* COLORS */

      /* Nord */
      @define-color bg #2E3440;
      @define-color light #D8DEE9;
      @define-color warning #ebcb8b;
      @define-color critical #BF616A;
      @define-color mode #434C5E;
      @define-color workspacesfocused #4C566A;
      @define-color tray @workspacesfocused;
      @define-color sound #EBCB8B;
      @define-color network #5D7096;
      @define-color memory #546484;
      @define-color cpu #596A8D;
      @define-color temp #4D5C78;
      @define-color layout #5e81ac;
      @define-color battery #88c0d0;
      @define-color date #434C5E;
      @define-color time #434C5E;
      @define-color backlight #434C5E;
      @define-color nord_bg #434C5E;
      @define-color nord_bg_blue #546484;
      @define-color nord_light #D8DEE9;
      @define-color nord_light_font #D8DEE9;
      @define-color nord_dark_font #434C5E;

      /* Reset all styles */
      * {
          border: none;
          border-radius: 3px;
          min-height: 0;
          margin: 0.2em 0.3em 0.2em 0.3em;
      }

      /* The whole bar */
      #waybar {
          background: @bg;
          color: @light;
          font-family: "Iosevka Nerd Font", "Iosevka Nerd Font Mono";
          font-size: 12px;
          font-weight: bold;
      }

      /* Each module */
      #battery,
      #clock,
      #cpu,
      #custom-layout,
      #memory,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #custom-alsa,
      #custom-pacman,
      #custom-weather,
      #custom-gpg-agent,
      #tray,
      #backlight,
      #language,
      #custom-currentplayer,
      #custom-player,
      #custom-cpugovernor {
          padding-left: 0.6em;
          padding-right: 0.6em;
      }

      /* Each module that should blink */
      #mode,
      #memory,
      #temperature,
      #battery {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      /* Each critical module */
      #memory.critical,
      #cpu.critical,
      #temperature.critical,
      #battery.critical {
          color: @critical;
      }

      /* Each critical that should blink */
      #mode,
      #memory.critical,
      #temperature.critical,
      #battery.critical.discharging {
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      /* Each warning */
      #network.disconnected,
      #memory.warning,
      #cpu.warning,
      #temperature.warning,
      #battery.warning {
          background: @warning;
          color: @nord_dark_font;
      }

      /* Each warning that should blink */
      #battery.warning.discharging {
          animation-name: blink-warning;
          animation-duration: 3s;
      }

      /* Workspaces stuff */

      #workspaces {
       /*   color: #D8DEE9;
          margin-right: 10px;*/
      }

      #workspaces button {
          font-weight: bold; /* Somewhy the bar-wide setting is ignored*/
          padding: 0;
          /*color: #999;*/
          opacity: 0.3;
          background: none;
          font-size: 1em;
      }

      #workspaces button.focused {
          background: @workspacesfocused;
          color: #D8DEE9;
          opacity: 1;
          padding: 0 0.4em;
      }

      #workspaces button.urgent {
          border-color: #c9545d;
          color: #c9545d;
          opacity: 1;
      }

      #window {
          margin-right: 40px;
          margin-left: 40px;
          font-weight: normal;
      }
      #bluetooth {
          background: @nord_bg_blue;
          font-size: 1.2em;
          font-weight: bold;
          padding: 0 0.6em;
      }
      #custom-gpu {
          background: @nord_bg;
          font-weight: bold;
          padding: 0 0.6em;
      }
      #custom-weather {
          background: @mode;
          font-weight: bold;
          padding: 0 0.6em;
      }
      #custom-pacman {
          background: @nord_light;
          color: @nord_dark_font;
          font-weight: bold;
          padding: 0 0.6em;
      }
      #custom-scratchpad-indicator {
          background: @nord_light;
          color: @nord_dark_font;
          font-weight: bold;
          padding: 0 0.6em;
      }
      #idle_inhibitor {
          background: @mode;
          /*font-size: 1.6em;*/
          font-weight: bold;
          padding: 0 0.6em;
      }
      #custom-alsa {
          background: @sound;
      }

      #network {
          background: @nord_bg_blue;
      }

      #memory {
          background: @memory;
      }

      #cpu {
          background: @nord_bg;
          color: #D8DEE9;
      }
      #cpu.critical {
          color: @nord_dark_font;
      }
      #language {
          background: @nord_bg_blue;
          color: #D8DEE9;
          padding: 0 0.4em;
      }
      #custom-cpugovernor {
          background-color: @nord_light;
          color: @nord_dark_font;
      }
      #custom-cpugovernor.perf {

      }
      #temperature {
          background-color: @nord_bg;
          color: #D8DEE9;
      }
      #temperature.critical {
          background:  @critical;
      }
      #custom-layout {
          background: @layout;
      }

      #battery {
          background: @battery;
      }

      #backlight {
          background: @backlight;
      }

      #clock {
          background: @nord_bg_blue;
          color: #D8DEE9;
      }
      #clock.date {
          background: @date;
      }

      #clock.time {
          background: @mode;
      }

      #pulseaudio { /* Unsused but kept for those who needs it */
          background: @nord_bg_blue;
          color: #D8DEE9;
      }

      #pulseaudio.muted {
          background: #BF616A;
          color: #BF616A;
          /* No styles */
      }
      #pulseaudio.source-muted {
          background: #D08770;
          color: #D8DEE9;
          /* No styles */
      }
      #tray {
          background: #434C5E;
      }

      #custom-gpg-agent {
          background: #434C5E;
      }
    '';
  };
}
