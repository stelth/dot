{pkgs, ...}: {
  networking = {
    hostName = "kvasir";

    interfaces.eno1.useDHCP = true;
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

  security.polkit.enable = true;

  system.stateVersion = "22.05";
}
