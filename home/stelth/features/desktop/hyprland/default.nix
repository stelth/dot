{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ../common/wayland-wm
  ];

  home.packages = with pkgs; [
    grimblast
    hyprpaper
    swayidle
  ];

  xdg.configFile."hypr/rose-pine.conf".text = import ./rose-pine.nix {};

  programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
    mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
    patches =
      (oa.patches or [])
      ++ [
        (pkgs.fetchpatch {
          name = "Fix waybar hyprctl";
          url = "https://aur.archlinux.org/cgit/aur.git/plain/hyprctl.patch?h=waybar-hyprland-git";
          sha256 = "sha256-pY3+9Dhi61Jo2cPnBdmn3NUTSA8bAbtgsk2ooj4y7aQ=";
        })
      ];
  });

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ./config.nix {
      inherit (config) home;
    };
  };

  xdg.configFile."hypr/wallpaper.png".source = ./wallpaper.png;

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.config/hypr/wallpaper.png
    wallpaper = ,~/.config/hypr/wallpaper.png
  '';
}
