{pkgs, ...}: {
  hardware.keyboard.qmk.enable = true;

  environment.systemPackages = with pkgs; [
    via
  ];

  services.udev.packages = with pkgs; [via];

  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0660", GROUP="users" TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0660", GROUP="users" TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3434", MODE="0660", GROUP="users", TAG+="uaccess"
  '';
}
