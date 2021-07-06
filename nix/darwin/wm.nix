{ config, pkgs, ... }:

{
  services.spacebar.enable = false;
  services.spacebar.package = pkgs.spacebar;
}
