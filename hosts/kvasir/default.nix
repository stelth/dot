{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/stelth

    ../common/optional/1password.nix
    ../common/optional/pipewire.nix
    ../common/optional/sddm.nix
  ];

  networking = {
    hostName = "kvasir";
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  security.polkit.enable = true;

  system.stateVersion = "22.05";
}
