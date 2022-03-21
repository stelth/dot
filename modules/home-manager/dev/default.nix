{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    cmake
    gh
    hub
    lldb
    lua
    maven
    ninja
    nodejs_latest
    openjdk
    rustc
    cargo
  ];

  programs.ssh = {
    enable = true;

    matchBlocks = {
      "10.* 172.* 192.*" = {
        user = "root";
        identitiesOnly = true;
        identityFile = "~/.ssh/keys/id_rsa.cleversafelabs";
        serverAliveInterval = 50;
        extraOptions = { "StrictHostKeyChecking" = "no"; };
      };
      "github.com" =
        lib.hm.dag.entryBefore [ "10.* 172.* 192.*" ] { user = "stelth"; };
      "github.ibm.com" = lib.hm.dag.entryBefore [ "github.com" ] {
        user = "Jason.P.Cox@ibm.com";
      };
      "9.47.32.9" = lib.hm.dag.entryBefore [ "github.com" ] { user = "jcox"; };
    };
  };
}
