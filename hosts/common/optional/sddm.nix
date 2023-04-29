{...}: {
  programs.sway.enable = true;
  services.xserver = {
    enable = true;

    displayManager = {
      sddm = {
        enable = true;
        enableHidpi = true;
      };
    };
    libinput.enable = true;
  };
}
