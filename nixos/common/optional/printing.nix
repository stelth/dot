{pkgs, ...}: {
  services.printing.enable = true;
  services.printing.drivers = [pkgs.hplipWithPlugin];

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [pkgs.hplipWithPlugin];

  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;

  environment.persistence."/persist" = {
    directories = [
      "/var/lib/cups"
    ];
  };
}
