{...}: {
  networking = {
    hostName = "kvasir";

    interfaces.eno1.useDHCP = true;
  };

  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
  };

  hardware = {
    nvidia = {
      prime.offload.enable = false;
      modesetting.enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  security.polkit.enable = true;

  system.stateVersion = "22.05";
}
