{ inputs, config, pkgs, ... }: {
  imports = [ ./primary.nix ./nixpkgs.nix ./overlays.nix ];

  user = {
    description = "Jason Cox";
    home = "${
        if pkgs.stdenvNoCC.isDarwin then "/Users" else "/home"
      }/${config.user.name}";
    shell = pkgs.fish;
  };

  hm = import ./home-manager;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
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
      nixpkgs.source = "${pkgs.path}";
      stable.source = "${inputs.stable}";
    };
    shells = with pkgs; [ bash zsh fish ];
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ nerdfonts ibm-plex ];
  };
}
