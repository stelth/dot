{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

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
