# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0e79aab0-c525-49e2-8969-881775ee6aab";
    fsType = "ext4";
  };

  swapDevices = [{device = "/dev/disk/by-uuid/290950fc-6304-4dfb-b147-9759d19b36ff";}];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
