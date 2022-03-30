{ config, pkgs, ... }:
let theme = builtins.readFile ./kitty_tokyonight_night.conf;
in {
  programs.kitty = {
    enable = true;
    font = { name = "FiraCode Nerd Font"; };
    settings = {
      allow_remote_control = "socket-only";
      bold_font = "Fira Code Bold Nerd Font Complete";
      bold_italic_font = "Victor Mono Bold Italic Nerd Font Complete";
      copy_on_select = true;
      disable_ligatures = "cursor";
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      font_size = 11;
      hide_window_decorations = "titlebar-only";
      inactive_border_color = "#ff0000";
      italic_font = "Victor Mono Medium Italic Nerd Font Complete";
      kitty_mod = "cmd+shift";
      listen_on = "unix:/tmp/kitty";
      macos_option_as_alt = true;
      macos_thicken_font = "0.3";
      macos_traditional_fullscreen = true;
      open_url_modifiers = "kitty_mod";
      rectangle_select_modifiers = "ctrl+alt";
      scrollback_lines = 10000;
      shell_integration = "no-cursor";
      tab_bar_style = "powerline";
      tab_separator = "";
      terminal_select_modifiers = "shift";
      update_check_interval = 0;
      window_border_width = "1.0";
      window_padding_width = 5;
    };
    extraConfig = ''
      ${theme}
    '';
  };
}
