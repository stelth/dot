# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = ["ata_generic" "ehci_pci" "ahci" "isci" "xhci_pci" "usbhid" "sd_mod" "sr_mod"];
      kernelModules = ["kvm-intel"];
    };

    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "/dev/sda";
        configurationLimit = 10;
      };
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1b52376d-4c3b-4f0d-bcf8-c74cc1b4fe7c";
    fsType = "ext4";
  };

  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-uuid/1582dcc3-77cc-4641-922d-49fe8549eaba";
    fsType = "ext4";
  };

  swapDevices = [];

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
}
