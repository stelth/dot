{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./locale.nix
      ./nix.nix
      ./openssh.nix
      ./optin-persistence.nix
      ./sops.nix
      ./systemd-initrd.nix
      ./yubikey.nix
      ./zsh.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  environment.enableAllTerminfo = true;

  environment.systemPackages = [pkgs.sysdo];

  hardware.enableRedistributableFirmware = true;
}
