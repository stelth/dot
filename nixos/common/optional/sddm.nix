{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  services = {
    xserver = {
      enable = true;

      videoDrivers = ["nvidia"];

      displayManager = {
        sddm = {
          enable = true;
          enableHidpi = true;
          wayland.enable = true;
        };
      };

      libinput.enable = true;
    };

    desktopManager.plasma6.enable = true;
  };
}
