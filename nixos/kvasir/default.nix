{...}: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix

    ../common/global
    ../common/users/stelth

    ../common/optional/1password.nix
    ../common/optional/keyboards
    ../common/optional/libvirt.nix
    ../common/optional/pipewire.nix
    ../common/optional/podman.nix
    ../common/optional/printing.nix
    ../common/optional/sddm.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/workvpn.nix
  ];
}
