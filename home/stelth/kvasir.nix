{
  inputs,
  outputs,
  ...
}: let
  inherit (inputs.nix-colors.colorSchemes) rose-pine-moon;
in {
  imports = [
    ./global
    ./features/cli
    ./features/desktop/hyprland
    ./features/vim
    ./features/music
    ./features/wine
  ];

  colorscheme = rose-pine-moon;
  wallpaper = outputs.wallpapers.kosmos-space-dark;
}
