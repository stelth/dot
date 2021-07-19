{ config, pkgs, ... }:
{
  xdg.configFile."yabai".source = ../../../config/yabai;
}
