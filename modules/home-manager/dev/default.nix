{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    python39
    python39Packages.pip
    python39Packages.pipx
    cmake
    gh
    go
    hub
    lua
    maven
    nodejs
    nodePackages.pnpm
    nodePackages.yarn
    openjdk
    rustc
    cargo
  ];

  programs.ssh = {
    enable = true;

    matchBlocks = {
      "10.* 172.* 192.*" = {
        user = "root";
        identityFile =
          "~/dot/modules/home-manager/dotfiles/ssh/id_rsa.cleversafelabs";
        serverAliveInterval = 50;
        extraOptions = { "StrictHostKeyChecking" = "no"; };
      };
      "github.com" = lib.hm.dag.entryBefore [ "10.* 172.* 192.*" ] {
        user = "stelth";
        identityFile =
          "~/dot/modules/home-manager/dotfiles/ssh/id_ed25519_github";
      };
      "github.ibm.com" = lib.hm.dag.entryBefore [ "github.com" ] {
        identityFile = "~/dot/modules/home-manager/dotfiles/ssh/id_ed25519_ibm";
        user = "Jason.P.Cox@ibm.com";
      };
      "9.55.36.195" = lib.hm.dag.entryBefore [ "github.com" ] {
        identityFile =
          "~/dot/modules/home-manager/dotfiles/ssh/id_ed25519_logserver";
        user = "Jason.P.Cox";
      };
    };
  };
}
