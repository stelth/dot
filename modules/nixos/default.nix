{
  config,
  pkgs,
  ...
}: {
  # bundles essential nixos modules
  imports = [../common.nix ./graphics.nix];

  # manually disable this to resolve https://github.com/NixOS/nixos-hardware/issues/260
  # TODO: resolve this later
  services.power-profiles-daemon.enable = false;

  hm = {...}: {};

  boot.readOnlyNixStore = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    groups.localtimed = {};
    users = {
      localtimed.group = "localtimed";
      "${config.user.name}" = {
        isNormalUser = true;
        createHome = true;
        useDefaultShell = true;
        extraGroups = ["wheel" "networkmanager" "audio"]; # Enable ‘sudo’ for the user.
        hashedPassword = "$6$mwlr.3ZwTZHQDLHS$gCnJwFaZuwt7qN2qWYkkuBgdbBA/FpedYz09WKZm2BwnRf/JpEzb0rCLlksnNFkd2wUduPgn7b.DMp1PcW1yT.";
      };
    };
  };

  networking.hostName = "nixDev"; # Define your hostname.

  # Use the GRUB 2 boot loader.

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda"; # or "nodev" for efi only
    configurationLimit = 10;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = pkgs.jetbrains-mono;
  #   keyMap = "us";
  # };

  # Set your time zone.
  services.geoclue2.enable = true;
  services.localtimed.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="wheel"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="wheel"
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
