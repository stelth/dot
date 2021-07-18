{ pkgs, ... }:
{
  programs.starship.enable = true;
  programs.starship.enableFishIntegration = true;
  programs.starship.settings.add_newline = true;
}
