{pkgs, ...}: {
  services = {
    pcscd.enable = true;
    udev = {
      packages = with pkgs; [yubikey-personalization gnupg];
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
