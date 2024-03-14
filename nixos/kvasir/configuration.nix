{pkgs, ...}: {
  networking = {
    hostName = "kvasir";
    networkmanager.enable = true;
  };

  hardware = {
    nvidia = {
      prime.offload.enable = false;
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
      ];
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.network.wait-online.enable = false;

  services.fstrim.enable = true;

  security.polkit.enable = true;

  system.stateVersion = "22.05";
}
