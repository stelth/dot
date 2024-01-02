{pkgs, ...}: {
  services = {
    pcscd.enable = true;
    udev = {
      packages = with pkgs; [yubikey-personalization gnupg];
      extraRules = ''
        ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0407", RUN+="${pkgs.gnupg}/bin/gpg --card-status"
      '';
    };
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  environment.systemPackages = with pkgs; [
    yubikey-personalization
  ];
}
