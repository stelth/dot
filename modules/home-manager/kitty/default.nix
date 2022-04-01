{ config, pkgs, ... }:
let theme = builtins.readFile ./kitty_tokyonight_night.conf;
in {
  programs.kitty = {
    enable = true;
    font = { name = "FiraCode Nerd Font"; };
    settings = {
      allow_remote_control = "socket-only";
      bold_font = "FiraCode Nerd Font Mono Bold";
      bold_italic_font = "VictorMono Nerd Font Mono Bold Italic";
      copy_on_select = true;
      disable_ligatures = "always";
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      font_size = 11;
      hide_window_decorations = "titlebar-only";
      inactive_border_color = "#ff0000";
      italic_font = "VictorMono Nerd Font Mono Medium Italic";
      kitty_mod = "cmd+shift";
      listen_on = "unix:/tmp/kitty";
      macos_option_as_alt = true;
      macos_traditional_fullscreen = true;
      scrollback_lines = 10000;
      shell_integration = "no-cursor";
      tab_bar_style = "powerline";
      tab_separator = "";
      update_check_interval = 0;
      window_border_width = "1.0";
      window_padding_width = 5;
    };
    extraConfig = ''
      ${theme}
    '';
  };
}
