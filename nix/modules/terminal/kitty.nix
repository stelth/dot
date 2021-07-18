{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 11;
    };
    extraConfig = ''
      bold_font        FiraCode Nerd Font Bold
      italic_font      VictorMono Nerd Font Light Italic
      bold_italic_font VictorMono Nerd Font Bold Italic

      disable_ligatures cursor

      kitty_mod cmd+shift

      open_url_modifiers kitty_mod
      copy_on_select yes
      rectangle_select_modifiers ctrl+alt
      terminal_select_modifiers shift
      enable_audio_bell no
      window_border_width 1.0
      inactive_border_color #ff0000
      hide_window_decorations titlebar-only
      tab_bar_style powerline
      tab_separator " "
      dynamic_background_opacity yes
      allow_remote_control socket-only
      listen_on unix:/tmp/kitty
      update_check_interval 0
      macos_option_as_alt yes
      macos_thicken_font 0.3
      macos_traditional_fullscreen yes

      background #24283a
      foreground #c0caf5
      selection_background #33467C
      selection_foreground #c0caf5
      url_color #73daca
      cursor #c0caf5

      # Tabs
      active_tab_background #7aa2f7
      active_tab_foreground #1f2335
      inactive_tab_background #292e42
      inactive_tab_foreground #545c7e
      #tab_bar_background #15161E

      # normal
      color0 #15161E
      color1 #f7768e
      color2 #9ece6a
      color3 #e0af68
      color4 #7aa2f7
      color5 #bb9af7
      color6 #7dcfff
      color7 #a9b1d6

      # bright
      color8 #414868
      color9 #f7768e
      color10 #9ece6a
      color11 #e0af68
      color12 #7aa2f7
      color13 #bb9af7
      color14 #7dcfff
      color15 #c0caf5

      # extended colors
      color16 #ff9e64
      color17 #db4b4b
    '';
  };
}
