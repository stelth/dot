{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./locale.nix
      ./nix.nix
      ./systemd-initrd.nix
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

  hardware.enableRedistributableFirmware = true;
}
