{pkgs, ...}: {
  networking = {
    hostName = "kvasir";

    useNetworkd = true;
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

  services.fstrim.enable = true;
  systemd.network.wait-online.enable = false;
  security.polkit.enable = true;

  system.stateVersion = "22.05";
}
