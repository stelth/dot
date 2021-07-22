{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ./primary.nix
    ./nixpkgs.nix
  ];

  user = {
    description = "Jason Cox";
    home = "${if pkgs.stdenvNoCC.isDarwin then "/Users" else "/home"}/${config.user.name}";
    shell = pkgs.fish;
  };

  hm = import ./home-manager;

  home-manager = {
    extraSpecialArgs = { inherit inputs lib; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "orig";
  };

  environment = {
    systemPackages = with pkgs; [
      coreutils
      curl
      wget
      git
      jq

      bat
      fzf
      ripgrep
    ];
    etc = {
      home-manager.source = "${inputs.home-manager}";
      nixpkgs.source = "${inputs.nixpkgs}";
    };
    shells = with pkgs; [
      bash
      zsh
      fish
    ];
  };

  fonts.fonts = with pkgs; [
    (
      nerdfonts.override {
        fonts = [
          "FiraCode"
          "DejaVuSansMono"
          "JetBrainsMono"
          "FantasqueSansMono"
          "VictorMono"
          "SourceCodePro"
        ];
      }
    )
    ibm-plex
  ];
}
