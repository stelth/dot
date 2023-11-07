{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    catppuccin-sddm-corners
    libsForQt5.qt5.qtgraphicaleffects
  ];

  programs.hyprland.enable = true;
  services.xserver = {
    enable = true;

    displayManager = {
      sddm = {
        enable = true;
        enableHidpi = true;
        theme = "catppuccin-sddm-corners";
      };
    };
    libinput.enable = true;
  };
}
