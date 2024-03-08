{pkgs, ...}: {
  hardware.keyboard.qmk.enable = true;

  environment.systemPackages = with pkgs; [
    via
  ];
  # Keychron Keychron Q2 Max
  services.udev.packages = with pkgs; [via];
  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="wheel"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="wheel"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3434", MODE="0664", GROUP="wheel"
  '';
}
