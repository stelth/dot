{pkgs, ...}: {
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [virt-manager];

  fileSystems = {
    "/srv/vms" = {
      device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      options = ["subvol=vms" "noatime" "compress=zstd"];
    };
  };
}
