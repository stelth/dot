# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    ../common/optional/ephemeral-btrfs.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi = {
        canTouchEfiVariables = true;
      };

      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
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

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
}
