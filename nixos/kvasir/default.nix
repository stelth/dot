{inputs, ...}: {
  imports = [
    inputs.srvos.nixosModules.common
    inputs.srvos.nixosModules.mixins-trusted-nix-caches
    inputs.srvos.nixosModules.desktop
    inputs.srvos.nixosModules.mixins-systemd-boot

    ./configuration.nix
    ./hardware-configuration.nix

    ../common/global
    ../common/users/stelth

    ../common/optional/1password.nix
    ../common/optional/keyboards
    ../common/optional/libvirt.nix
    ../common/optional/podman.nix
    ../common/optional/printing.nix
    ../common/optional/sddm.nix
    ../common/optional/workvpn.nix
  ];
}
