# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    ../modules/ephemeral-btrfs.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi = {
        efiSysMountPoint = "/efi";
      };
    };
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

  fileSystems = {
    "/srv/logs" = {
      device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      options = ["subvol=logs" "noatime" "compress=zstd"];
    };
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 8196;
    }
  ];

  hardware.cpu.intel.updateMicrocode = true;
}
