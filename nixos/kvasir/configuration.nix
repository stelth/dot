{...}: {
  imports = [
    ./hardware-configuration.nix

    ../modules/yubikey.nix
    ../modules/1password.nix
    ../modules/ergodox.nix
    ../modules/printing.nix
    ../modules/sddm.nix
  ];

  networking = {
    hostName = "kvasir";

    interfaces.eno1.useDHCP = true;
  };

  time.timeZone = null;
  services = {
    geoclue2.enable = true;
    openssh.enable = true;
  };

  programs.vim.defaultEditor = true;

  security.polkit.enable = true;

  system.stateVersion = "22.05";
}
