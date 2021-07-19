{ config, pkgs, ... }:
{
  xdg.configFile."skhd".source = ../../../config/skhd;
}
