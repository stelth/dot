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

      defaultSession = "plasmawayland";
    };

    desktopManager.plasma5.enable = true;

    libinput.enable = true;
  };
}
