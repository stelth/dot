{pkgs, ...}: {
  networking = {
    hostName = "kvasir";
  };

  systemd = {
    services.NetworkManager-wait-online.enable = pkgs.lib.mkForce false;

    network = {
      enable = true;

      networks."10-lan" = {
        matchConfig.Name = "lan";
        networkConfig.DHCP = "yes";
      };
    };
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
