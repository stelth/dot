{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    python39
    python39Packages.pip
    python39Packages.pipx
    adoptopenjdk-bin
    cmake
    gh
    go
    hub
    lua
    nodejs
    nodePackages.pnpm
    nodePackages.yarn
    rustc
    cargo
  ];

  programs.ssh = {
    enable = true;

    matchBlocks = {
      "10.137.* 10.136.9.* 172.18.30.* 172.19.* 192.168.*" = {
        user = "root";
        identityFile =
          "~/dot/modules/home-manager/dotfiles/ssh/id_rsa.cleversafelabs";
        serverAliveInterval = 50;
        extraOptions = { "StrictHostKeyChecking" = "no"; };
      };
      "github.com" = lib.hm.dag.entryBefore
        [ "10.137.* 10.136.9.* 172.18.30.* 172.19.* 192.168.*" ] {
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
