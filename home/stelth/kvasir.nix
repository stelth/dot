{outputs, ...}: {
  imports = [
    ./global
    ./features/cli
    ./features/desktop/hyprland
    ./features/vim
    ./features/music
    ./features/wine
  ];

  wallpaper = outputs.wallpapers.kosmos-space-dark;
}
