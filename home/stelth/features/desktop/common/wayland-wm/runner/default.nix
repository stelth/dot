{pkgs, ...}: {
  home.packages = [pkgs.rofi-wayland];

  xdg.configFile."rofi/config.rasi".text = import ./catppuccin.nix {};
}
