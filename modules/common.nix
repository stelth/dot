{
  self,
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./primary.nix ./nixpkgs.nix];

  nixpkgs.overlays = builtins.attrValues self.overlays;

  programs.fish.enable = true;
  programs.zsh.enable = true;

  user = {
    description = "Jason Cox";
    home = "${
      if pkgs.stdenvNoCC.isDarwin
      then "/Users"
      else "/home"
    }/${config.user.name}";
    shell = pkgs.fish;
  };

  hm = import ./home-manager;

  home-manager = {
    extraSpecialArgs = {inherit self inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "orig";
  };

  environment = {
    systemPackages = with pkgs; [
      coreutils-full
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
      stable.source = "${inputs.stable}";
    };
    shells = with pkgs; [bash zsh fish];
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [nerdfonts ibm-plex];
  };
}
