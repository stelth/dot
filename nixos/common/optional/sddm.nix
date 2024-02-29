{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

  services.xserver = {
    enable = true;

    displayManager = {
      sddm = {
        enable = true;
        enableHidpi = true;
        wayland.enable = true;
      };
    };

    desktopManager.plasma6.enable = true;

    libinput.enable = true;
  };
}
