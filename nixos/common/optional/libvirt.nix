{pkgs, ...}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          })
          .fd
        ];
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [virt-manager];
    persistence = {
      "/persist".directories = [
        "/var/lib/libvirt"
      ];
    };
  };

  fileSystems = {
    "/srv/vms" = {
      device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      options = ["subvol=vms" "noatime" "compress=zstd"];
    };
  };
}
