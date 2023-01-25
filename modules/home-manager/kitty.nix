{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    package = pkgs.stable.kitty;
    font = {name = "FiraCode Nerd Font Mono";};
    theme = "Tokyo Night";
    keybindings = {
      "cmd+c" = "copy_to_clipboard";
      "cmd+v" = "paste_from_clipboard";
    };
    settings = {
      allow_remote_control = "socket-only";
      bold_font = "FiraCode Bold Nerd Font Mono";
      bold_italic_font = "VictorMono Nerd Font Mono Bold Italic";
      clear_all_shortcuts = true;
      copy_on_select = true;
      disable_ligatures = "always";
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      font_size = 11;
      hide_window_decorations = "titlebar-only";
      inactive_border_color = "#ff0000";
      italic_font = "VictorMono Nerd Font Mono Italic";
      kitty_mod = "cmd+shift";
      listen_on = "unix:/tmp/kitty";
      macos_option_as_alt = true;
      macos_thicken_font = "0.3";
      macos_traditional_fullscreen = true;
      scrollback_lines = 10000;
      shell_integration = "no-cursor";
      tab_bar_style = "powerline";
      tab_separator = "";
      update_check_interval = 0;
      window_border_width = "1.0";
      window_padding_width = 5;
    };
  };
}
