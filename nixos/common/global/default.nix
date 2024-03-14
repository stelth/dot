{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./optin-persistence.nix
    ./sops.nix
    ./sudo.nix
    ./systemd-initrd.nix
    ./upgrade-diff.nix
    ./yubikey.nix
    ./zsh.nix
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nixpkgs = {
    overlays = [outputs.overlays.default];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  environment.enableAllTerminfo = true;

  environment.systemPackages = [pkgs.sysdo];

  hardware.enableRedistributableFirmware = true;
}
