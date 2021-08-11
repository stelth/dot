{ config, pkgs, ... }: {
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    config = {
      mouse_follows_focus = "off";
      focus_follows_mouse = "off";
      window_placement = "second_child";
      window_topmost = "on";
      window_opacity = "off";
      window_opacity_duration = 0.0;
      window_shadow = "on";
      window_border = "off";
      window_border_width = 6;
      active_window_border_color = "0xff775759";
      normal_window_border_color = "0xff555555";
      active_window_opacity = 1.0;
      normal_window_opacity = 0.95;
      split_ratio = 0.5;
      auto_balance = " off ";
      mouse_modifier = " fn ";
      mouse_action1 = " move ";
      mouse_action2 = " resize ";
      layout = " bsp ";
      top_padding = 5;
      bottom_padding = 5;
      left_padding = 5;
      right_padding = 5;
      window_gap = 5;
    };
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = builtins.readFile ../home-manager/dotfiles/skhd/skhdrc;
  };
}
