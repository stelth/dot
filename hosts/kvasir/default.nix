{inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ./configuration.nix
    ./hardware-configuration.nix

    ../common/global
    ../common/users/stelth

    ../common/optional/1password.nix
    ../common/optional/ergodox.nix
    ../common/optional/libvirt.nix
    ../common/optional/pipewire.nix
    ../common/optional/podman.nix
    ../common/optional/sddm.nix
    ../common/optional/workvpn.nix
  ];
}
