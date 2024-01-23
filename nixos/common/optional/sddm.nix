{...}: {
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];

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
