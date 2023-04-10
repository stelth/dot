{
  self,
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [./primaryUser.nix ./nixpkgs.nix];

  nixpkgs.overlays = builtins.attrValues self.overlays;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };

  user = {
    description = "Jason Cox";
    home = "${
      if pkgs.stdenvNoCC.isDarwin
      then "/Users"
      else "/home"
    }/${config.user.name}";
    shell = pkgs.zsh;
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
      moreutils
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
    fonts = with pkgs; [jetbrains-mono];
  };
}
