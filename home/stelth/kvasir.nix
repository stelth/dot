{inputs, ...}: let
  inherit (inputs.nix-colors.colorSchemes) onedark;
in {
  imports = [
    ./global
    ./features/cli
    ./features/vim
    ./features/music
    ./features/desktop/hyprland
  ];

  colorscheme = onedark;
  wallpaper = (import ./wallpapers).aenami-omen;

  monitors = [
    {
      name = "DP-1";
      width = 1920;
      height = 1080;
      workspace = "1";
    }
    {
      name = "DP-2";
      width = 1920;
      height = 1080;
      workspace = "2";
      x = 1920;
    }
  ];
}
