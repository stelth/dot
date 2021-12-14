{ config, pkgs, ... }:
let theme = builtins.readFile ./kitty_nord.conf;
in {
  programs.kitty = {
    enable = true;
    font = { name = "FiraCode Nerd Font"; };
    settings = {
      bold_font = "Fira Code Bold Nerd Font Complete";
      italic_font = "Victor Mono Medium Italic Nerd Font Complete";
      bold_italic_font = "Victor Mono Bold Italic Nerd Font Complete";
      font_size = 11;
      enable_audio_bell = false;
      macos_option_as_alt = true;
      scrollback_lines = 10000;
      disable_ligatures = "cursor";
      kitty_mod = "cmd+shift";
      open_url_modifiers = "kitty_mod";
      copy_on_select = true;
      rectangle_select_modifiers = "ctrl+alt";
      terminal_select_modifiers = "shift";
      window_border_width = "1.0";
      inactive_border_color = "#ff0000";
      hide_window_decorations = "titlebar-only";
      tab_bar_style = "powerline";
      tab_separator = "";
      dynamic_background_opacity = true;
      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty";
      update_check_interval = 0;
      macos_thicken_font = "0.3";
      macos_traditional_fullscreen = true;
      window_padding_width = 5;
    };
    extraConfig = ''
      ${theme}
    '';
  };
}
