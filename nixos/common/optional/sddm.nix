{inputs, ...}: {
  imports = [
    inputs.kde6.nixosModules.plasma6
  ];
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];

    displayManager = {
      sddm = {
        enable = true;
        enableHidpi = true;
      };

      defaultSession = "plasma";
    };

    desktopManager.plasma6.enable = true;

    libinput.enable = true;
  };
}
