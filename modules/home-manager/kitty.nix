{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    package = pkgs.stable.kitty;
    theme = "One Dark";
    keybindings = {
      "cmd+c" = "copy_to_clipboard";
      "cmd+v" = "paste_from_clipboard";
    };
    settings = {
      allow_remote_control = "socket-only";
      copy_on_select = true;
      disable_ligatures = "always";
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      font_size = 11;
      hide_window_decorations = "titlebar-only";
      inactive_border_color = "#ff0000";
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
